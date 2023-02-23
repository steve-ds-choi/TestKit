//
//  Control+Extension.swift
//  TestKit
//
//  Created by steve on 2023/02/16.
//

import UIKit
import Combine

extension UIControl {

    func controlPublisher(for event: UIControl.Event) -> UIControl.EventPublisher {
        UIControl.EventPublisher(control: self, event: event)
    }

    // Publisher
    struct EventPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never

        let control: UIControl
        let event: UIControl.Event

        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = EventSubscription(control: control, subscrier: subscriber, event: event)
            subscriber.receive(subscription: subscription)
        }
    }

    // Subscription
    fileprivate class EventSubscription<EventSubscriber: Subscriber>: Subscription where EventSubscriber.Input == UIControl, EventSubscriber.Failure == Never {

        let control: UIControl
        let event: UIControl.Event
        var subscriber: EventSubscriber?

        init(control: UIControl, subscrier: EventSubscriber, event: UIControl.Event) {
            self.control = control
            self.subscriber = subscrier
            self.event = event

            control.addTarget(self, action: #selector(eventDidOccur), for: event)
        }

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {
            subscriber = nil
            control.removeTarget(self, action: #selector(eventDidOccur), for: event)
        }

        @objc func eventDidOccur() {
            _ = subscriber?.receive(control)
        }
    }
}

extension UIButton {

    var publisher: AnyPublisher<Int, Never> {
        controlPublisher(for: .touchUpInside)
            .map { $0.tag }
            .eraseToAnyPublisher()
    }
}

extension UITextField {

    var publisher: AnyPublisher<String, Never> {
        controlPublisher(for: .editingChanged)
            .map { $0 as! UITextField }
            .map { $0.text! }
            .eraseToAnyPublisher()
    }

    func clear() {
        text = ""
        sendActions(for: .editingChanged)
    }
}

extension UITableView {

    func registerCell<T>(_ cls: T.Type) where T: UITableViewCell {
        let name = "\(cls)"
        let nib = UINib(nibName:name, bundle:nil)
        register(nib, forCellReuseIdentifier: name)
    }

    func dequeueCell<T>(_ cls: T.Type) -> T {
        let name = "\(cls)"
        let cell = dequeueReusableCell(withIdentifier: name)!
        cell.selectionStyle = .none

        return cell as! T
    }
}

extension UILabel {

    private func addAttr(txts: NSMutableAttributedString, _ color: UIColor, _ font: UIFont!, _ range: NSRange) {
        txts.addAttribute(.foregroundColor, value:color, range:range)

        if font != nil {
            txts.addAttribute(.font, value:font!, range:range)
        }
    }

    private func addAttr(_ txts: NSMutableAttributedString, _ attr: String, _ color: UIColor, _ font: UIFont!) {
        let text = txts.string
        var range = text.range(of:attr, .caseInsensitive)

        while(range.length > 0) {
            addAttr(txts:txts, color, font, range)

            range = text.range(of:attr,
                               .caseInsensitive,
                               NSMakeRange(range.location+1, text.count - range.location - 1))
        }

        self.text = nil
        self.attributedText = txts
    }

    func setAttrText(_ text: String, attr: String, color: UIColor, font: UIFont! = nil) {
        if text.count == 0 { return }
        if attr.count == 0 {
            self.attributedText = nil
            self.text = text
            return
        }

        let txts = NSMutableAttributedString(string:text)
        addAttr(txts, attr, color, font)
    }
}
