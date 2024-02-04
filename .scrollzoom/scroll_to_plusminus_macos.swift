//
//  main.swift
//  scroll_to_plusminus
//
//  Created by uniqueidentifier on 2021-01-08.
//  Modified by alex on 2022-07-08 to use modifiers for scrolling
//  Modified by BalazsGyarmati on 2023-01-04 to use command instead of control + respect any keyboard layout for + and -
//

import Foundation
import CoreGraphics

//
// https://jjrscott.com/how-to-convert-ascii-character-to-cgkeycode/
//  CGKeyCodeInitializers.swift START
//
//  Created by John Scott on 09/02/2022.
//

import AppKit

extension CGKeyCode {
    public init?(character: String) {
        if let keyCode = Initializers.shared.characterKeys[character] {
            self = keyCode
        } else {
            return nil
        }
    }

    public init?(modifierFlag: NSEvent.ModifierFlags) {
        if let keyCode = Initializers.shared.modifierFlagKeys[modifierFlag] {
            self = keyCode
        } else {
            return nil
        }
    }

    public init?(specialKey: NSEvent.SpecialKey) {
        if let keyCode = Initializers.shared.specialKeys[specialKey] {
            self = keyCode
        } else {
            return nil
        }
    }

    private struct Initializers {
        let specialKeys: [NSEvent.SpecialKey:CGKeyCode]
        let characterKeys: [String:CGKeyCode]
        let modifierFlagKeys: [NSEvent.ModifierFlags:CGKeyCode]

        static let shared = Initializers()

        init() {
            var specialKeys = [NSEvent.SpecialKey:CGKeyCode]()
            var characterKeys = [String:CGKeyCode]()
            var modifierFlagKeys = [NSEvent.ModifierFlags:CGKeyCode]()

            for keyCode in (0..<128).map({ CGKeyCode($0) }) {
                guard let cgevent = CGEvent(keyboardEventSource: nil, virtualKey: CGKeyCode(keyCode), keyDown: true) else { continue }
                guard let nsevent = NSEvent(cgEvent: cgevent) else { continue }

                var hasHandledKeyCode = false
                if nsevent.type == .keyDown {
                    if let specialKey = nsevent.specialKey {
                        hasHandledKeyCode = true
                        specialKeys[specialKey] = keyCode
                    } else if let characters = nsevent.charactersIgnoringModifiers, !characters.isEmpty && characters != "\u{0010}" {
                        hasHandledKeyCode = true
                        characterKeys[characters] = keyCode
                    }
                } else if nsevent.type == .flagsChanged, let modifierFlag = nsevent.modifierFlags.first(.capsLock, .shift, .control, .option, .command, .help, .function) {
                    hasHandledKeyCode = true
                    modifierFlagKeys[modifierFlag] = keyCode
                }
                if !hasHandledKeyCode {
                    #if DEBUG
                    print("Unhandled keycode \(keyCode): \(nsevent)")
                    #endif
                }
            }
            self.specialKeys = specialKeys
            self.characterKeys = characterKeys
            self.modifierFlagKeys = modifierFlagKeys
        }
    }

}

extension NSEvent.ModifierFlags: Hashable { }

extension OptionSet {
    public func first(_ options: Self.Element ...) -> Self.Element? {
        for option in options {
            if contains(option) {
                return option
            }
        }
        return nil
    }
}
//  CGKeyCodeInitializers.swift END

func KeyPress(_ key: CGKeyCode, _ down: Bool, _ command: Bool) {
	if
		let source = CGEventSource( stateID: .privateState ),
		let event = CGEvent( keyboardEventSource: source, virtualKey: key, keyDown: down ) {
		if(command) {
			event.flags = CGEventFlags.maskCommand
		}
		event.type = down ? .keyDown : .keyUp
		event.post( tap: .cghidEventTap )
	}
}


/*
enum Key: CGKeyCode {
	case left = 123, right = 124, minus = 27, plus = 24, command = 55
	func press(_ down:Bool, _ command:Bool) {
		if
			let source = CGEventSource( stateID: .privateState ),
			let event = CGEvent( keyboardEventSource: source, virtualKey: rawValue, keyDown: down ) {
			if(command) {
				event.flags = CGEventFlags.maskCommand
			}
			event.type = down ? .keyDown : .keyUp
			event.post( tap: .cghidEventTap )
		}
	}
}
*/

class EventTap {

	static var rloop_source: CFRunLoopSource! = nil
	
	class func create(){
		
		if rloop_source != nil
			{ EventTap.remove() }
		
		let tap = CGEventTap.create( callback: tap_callback )!
		
		rloop_source
			= CFMachPortCreateRunLoopSource( kCFAllocatorDefault, tap, CFIndex(0) )
		CFRunLoopAddSource( CFRunLoopGetCurrent(),rloop_source, .commonModes )
		CGEvent.tapEnable( tap: tap, enable: true )
		CFRunLoopRun()
		
	}
	
	class func remove(){
		if rloop_source != nil {
			CFRunLoopRemoveSource( CFRunLoopGetCurrent(), rloop_source, .commonModes )
			rloop_source = nil
		}
	}
	
	@objc class func handle_event( proxy: CGEventTapProxy, type: CGEventType,
		event immutable_event: CGEvent!, refcon: UnsafeMutableRawPointer? ) -> CGEvent? {

		guard let event = immutable_event else { return nil }

		switch type {
		
			case .scrollWheel:

				let delta_y = event.getIntegerValueField(.scrollWheelEventDeltaAxis1)
				guard let plusKeyCode = CGKeyCode(character: "+") else { fatalError() }
				guard let minusKeyCode = CGKeyCode(character: "-") else { fatalError() }
				let key : CGKeyCode = (delta_y > 0) ? plusKeyCode : ( (delta_y < 0) ? minusKeyCode : 55 )
				let flagsP: CGEventFlags = event.flags;
				if ((flagsP.contains(CGEventFlags.maskCommand))) {
					/*
					if (delta_y != 0) {
					    print("cmd+scroll",delta_y)
					}
					*/
					KeyPress(key, true, true)
					KeyPress(key, false, true)
					return nil
				}
			    //print("scroll",delta_y)
				return event

			case .keyDown, .keyUp:
				//let code = event.getIntegerValueField(.keyboardEventKeycode)
				//print("Caught a keydown: \(code)! Flags: \(event.flags)")
				return event
				// fallthrough
				
			default:
				//let code1 = event.getIntegerValueField(.keyboardEventKeycode)
				//print("Caught a \(type): \(code1)!")
				//defer { exit_program() }
				return event

		}
		
	}
		
}

func exit_program(){
	EventTap.remove()
	exit(0)
}

private typealias CGEventTap = CFMachPort
extension CGEventTap {
	
	fileprivate class func create(
		callback: @escaping CGEventTapCallBack
	) -> CGEventTap? {
		
		/*
			leftMouseDown = 1
			leftMouseUp = 2
			rightMouseDown = 3
			rightMouseUp = 4
			mouseMoved = 5
			leftMouseDragged = 6
			rightMouseDragged = 7
			keyDown = 10
			keyUp = 11
			flagsChanged = 12
			scrollWheel = 22
			tabletPointer = 23
			tabletProximity = 24
			otherMouseDown = 25
			otherMouseUp = 26
			otherMouseDragged = 27
		*/
		
		let mask:  UInt32
			= (1 << 1) | (1 << 3) | (1 << 6) | (1 << 7) | (1 << 10) | (1 << 22) | (1 << 25) | (1 << 27)
		let tap: CFMachPort! = CGEvent.tapCreate(
			tap: .cgSessionEventTap /*.cghidEventTap*/,
			place: .headInsertEventTap,
			options: .defaultTap,
//			eventsOfInterest: CGEventMask( 1 << CGEventType.scrollWheel.rawValue ),
			eventsOfInterest: CGEventMask(mask),
			callback: callback,
			userInfo: nil
		)
		assert( tap != nil, "Failed to create event tap" )
		return tap
	}
	
}

let tap_callback: CGEventTapCallBack = {
	proxy, type, event, refcon in
	guard let event = EventTap.handle_event( proxy: proxy, type:type, event:event, refcon:refcon )
		else { return nil }
	return Unmanaged<CGEvent>.passRetained( event )
}

EventTap.create()
