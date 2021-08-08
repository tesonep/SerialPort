Class {
	#name : #SerialPortTest,
	#superclass : #TestCase,
	#instVars : [
		'sp'
	],
	#category : #SerialPort
}

{ #category : #tests }
SerialPortTest >> defaultTimeLimit [

	^ 1 minute
]

{ #category : #tests }
SerialPortTest >> portName [

	OSPlatform current isMacOSX ifTrue: [ ^ '/dev/cu.wchusbserial141330' ].
	OSPlatform current isUnix ifTrue: [ ^ '/dev/ttyUSB0' ].
	
	1halt

]

{ #category : #tests }
SerialPortTest >> tearDown [ 

	sp close
]

{ #category : #tests }
SerialPortTest >> testOpenArduino [

	sp := SerialPort new.
	sp baudRate: 38400.
	sp openPort: self portName.

	1 to: 10 do: [ :i | 
		sp writeByteArray: i printString utf8Encoded.
		(sp readByteArray: 10000) traceCr ]
]
