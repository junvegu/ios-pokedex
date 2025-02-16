//
//  File.swift
//  
//
//  Created by Junior on 18/09/22.
//

import UIKit
import Combine

public extension UITextField {

    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidBeginEditingNotification,
            object: self
        )
        .compactMap { ($0.object as? UITextField)?.text }
        .eraseToAnyPublisher()
    }

}
public protocol UIControlEventPublishing: UIControl {}

extension UIControl: UIControlEventPublishing {

    private class EventObserver<Control> where Control: UIControl {

        weak var control: Control?

        let event: UIControl.Event

        let subject: PassthroughSubject<Control, Never>

        init(control: Control, event: UIControl.Event) {
            self.control = control
            self.event = event
            self.subject = .init()
        }

        func start() {
            control?.addTarget(self, action: #selector(handleEvent(from:)), for: event)
        }

        func stop() {
            control?.removeTarget(self, action: nil, for: event)
        }

        @objc
        func handleEvent(from sender: UIControl) {
            subject.send(sender as! Control)
        }
    }

    public struct UIControlEventPublisher<Control>: Publisher where Control: UIControl {

        public typealias Output = Control

        public typealias Failure = Never

        public let control: Control

        public let event: UIControl.Event

        public init(control: Control, event: UIControl.Event) {
            self.control = control
            self.event = event
        }

        public func receive<S>(subscriber: S)
            where S: Subscriber,
            S.Failure == Failure,
            S.Input == Output {
                let observer = EventObserver(control: control, event: event)
                observer
                    .subject
                    .handleEvents(
                        receiveSubscription: { _ in observer.start() },
                        receiveCancel: observer.stop
                    )
                    .receive(subscriber: subscriber)
        }
    }
}

public extension UIControlEventPublishing {
    func eventPublisher(for event: UIControl.Event = .primaryActionTriggered) -> UIControlEventPublisher<Self> {
        .init(control: self, event: event)
    }
}

public extension UIControlEventPublishing where Self: UITextField {
    func textPublisher() -> AnyPublisher<String, Never> {
        eventPublisher(for: .editingChanged)
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
 
}
