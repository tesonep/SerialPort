"
I handle the differences for the OSX serial port implementation.
It only modifies the default class used as settings.
"
Class {
	#name : #OSXSerialPort,
	#superclass : #UnixSerialPort,
	#category : #SerialPort
}

{ #category : #constants }
OSXSerialPort class >> optionNOCTTY [
	
	^ "O_NOCTTY" 16r20000
]

{ #category : #constants }
OSXSerialPort class >> optionNONBLOCK [
	
	^ "O_NONBLOCK" 16r0004
]

{ #category : #constants }
OSXSerialPort class >> optionRDWR [
	
	^ "O_RDWR" 16r0002
]

{ #category : #settings }
OSXSerialPort >> newDefaultSettings [
	
	^ OSXSerialPortSettings new
]
