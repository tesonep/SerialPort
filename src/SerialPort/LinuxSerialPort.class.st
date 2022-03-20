"
I handle the differences for the Linux serial port implementation.
It only modifies the default class used as settings.
"
Class {
	#name : #LinuxSerialPort,
	#superclass : #UnixSerialPort,
	#category : #SerialPort
}

{ #category : #constants }
LinuxSerialPort class >> optionNOCTTY [
	
	^  "O_NOCTTY"  8r0400
]

{ #category : #constants }
LinuxSerialPort class >> optionNONBLOCK [
	
	^ "O_NONBLOCK"	  8r04000
]

{ #category : #constants }
LinuxSerialPort class >> optionRDWR [
	
	^ "O_RDWR"	8r02
]

{ #category : #settings }
LinuxSerialPort >> newDefaultSettings [ 

	^ LinuxSerialPortSettings new
]
