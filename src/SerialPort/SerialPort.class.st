"
This class supports a simple interface to the serial ports of the underlying platform, if it supports serial ports. The mapping of port numbers to hardware ports is platform specific, but typically follows platform ordering conventions. 
"
Class {
	#name : #SerialPort,
	#superclass : #Object,
	#instVars : [
		'port',
		'baudRate',
		'stopBitsType',
		'parityType',
		'dataBits',
		'outputFlowControlType',
		'inputFlowControlType',
		'xOnByte',
		'xOffByte'
	],
	#category : #SerialPort
}

{ #category : #private }
SerialPort >> backend [
	
	^ SerialPortBackend uniqueInstance
]

{ #category : #accessing }
SerialPort >> baudRate [

	^ baudRate

]

{ #category : #accessing }
SerialPort >> baudRate: anInteger [
	"Set the baud rate for this serial port."

	baudRate := anInteger
]

{ #category : #'open/close' }
SerialPort >> close [

	"Close the serial port. Do nothing if the port is not open."

	port ifNotNil: [ self backend closePort: port ].
	port := nil
]

{ #category : #accessing }
SerialPort >> dataBits [

	^ dataBits

]

{ #category : #accessing }
SerialPort >> dataBits: anInteger [
	"Set the number of data bits for this serial port to 5, 6, 7, or 8."

	dataBits := anInteger

]

{ #category : #initialization }
SerialPort >> initialize [
	"Default port settings."

	super initialize.
	baudRate := 9600.	"9600 baud"
	stopBitsType := 1.	"one stop bit"
	parityType := 0.	"no parity"
	dataBits := 8.	"8 bits"
	outputFlowControlType := 0.	"none"
	inputFlowControlType := 0.	"none"
	xOnByte := 19.	"ctrl-S"
	xOffByte := 24	"ctrl-X"
]

{ #category : #accessing }
SerialPort >> inputFlowControlType [

	^ inputFlowControlType

]

{ #category : #accessing }
SerialPort >> inputFlowControlType: anInteger [
	"Set the type of input flow control, where:
		0 - none
		1 - XOn/XOff
		2 - hardware handshaking"

	inputFlowControlType := anInteger

]

{ #category : #'input/output' }
SerialPort >> nextPutAll: aStringOrByteArray [
	"Send the given bytes out this serial port. The port must be open."

	<deprecated: 'We should only write byteArrays use writeByteArray: or writeFrom:starting:count:'>

	aStringOrByteArray isString ifTrue:[
			^ self writeByteArray: aStringOrByteArray utf8Encoded ]. 
	
	^ self writeByteArray: aStringOrByteArray. 

]

{ #category : #'open/close' }
SerialPort >> openPort: portId [

	"Open the given serial port, using the settings specified by my
	instance variables."

	| result |
	self close.

	result := self backend
		          openPort: portId
		          baudRate: baudRate
		          stopBitsType: stopBitsType
		          parityType: parityType
		          dataBits: dataBits
		          inFlowControlType: inputFlowControlType
		          outFlowControlType: outputFlowControlType
		          xOnByte: xOnByte
		          xOffByte: xOffByte.

	port := portId
]

{ #category : #accessing }
SerialPort >> outputFlowControlType [

	^ outputFlowControlType

]

{ #category : #accessing }
SerialPort >> outputFlowControlType: anInteger [
	"Set the type of output flow control, where:
		0 - none
		1 - XOn/XOff
		2 - hardware handshaking"

	outputFlowControlType := anInteger

]

{ #category : #accessing }
SerialPort >> parityType [

	^ parityType

]

{ #category : #accessing }
SerialPort >> parityType: anInteger [
	"Set the parity type for this serial port, where:
		0 - no parity
		1 - odd parity
		2 - even parity"

	parityType := anInteger

]

{ #category : #printing }
SerialPort >> printOn: aStream [

	aStream
		nextPutAll: 'SerialPort(';
		nextPutAll:
			(port ifNil: ['closed'] ifNotNil: ['#', port printString]);
		nextPutAll: ', ';
		print: baudRate; nextPutAll: ' baud, ';
		print: dataBits; nextPutAll: ' bits, ';
		nextPutAll: (#('1.5' '1' '2') at: stopBitsType + 1); nextPutAll: ' stopbits, ';
		nextPutAll: (#('no' 'odd' 'even') at: parityType + 1); nextPutAll: ' parity)'

]

{ #category : #'input/output' }
SerialPort >> readByteArray [
	"Answer a ByteArray read from this serial port. Answer an empty ByteArray if no data is available. The port must be open. "
	
	| buf count |
	buf := ByteArray new: 1000.
	
	count := self readInto: buf startingAt: 1 count: buf size.

	^ buf copyFrom: 1 to: count
]

{ #category : #'input/output' }
SerialPort >> readByteArray: timeout [
	"Read a byte array, if there is no data it waits until timeout in milliseconds"
	
	| buf count timeremaining|
	buf := ByteArray new: 1000.
	timeremaining := timeout.
	
	count := self readInto: buf startingAt: 1 count: buf size.
	
	[ count = 0 and: [timeremaining > 0]] 
		whileTrue: [ 
			10 milliSecond wait.
			timeremaining := timeremaining - 10.
			count := self readInto: buf startingAt: 1 count: buf size  ].
		
	timeremaining <= 0 ifTrue: [ self error: 'Timeout' ].
	
	^ buf copyFrom: 1 to: count
]

{ #category : #'input/output' }
SerialPort >> readInto: aByteArray startingAt: index count: count [
	"Read data into the given ByteArray object starting at the given index, and answer the number of bytes read."

	^ self backend readPort: port into: aByteArray startingAt: index count: count
	
]

{ #category : #'input/output' }
SerialPort >> readString [

	<deprecated: 'You should read a byte array and decode it correclty depending the encoding'>

	^ self readByteArray utf8Decoded
]

{ #category : #accessing }
SerialPort >> stopBitsType [

	^ stopBitsType

]

{ #category : #accessing }
SerialPort >> stopBitsType: anInteger [
	"Set the stop bits type for this serial port, where:
		0 - 1.5 stop bits
		1 - one stop bit
		2 - two stop bits"

	stopBitsType := anInteger

]

{ #category : #'input/output' }
SerialPort >> writeByteArray: aByteArray [
	
	^ self writeFrom: aByteArray startingAt: 1 count: aByteArray size
]

{ #category : #'input/output' }
SerialPort >> writeFrom: aByteArray startingAt: starting count: count [
	
	^ self backend writePort: port from: aByteArray startingAt: starting count: count
]

{ #category : #accessing }
SerialPort >> xOffByte [

	^ xOffByte

]

{ #category : #accessing }
SerialPort >> xOffByte: anInteger [
	"Set the value of the XOff byte to be used if XOn/XOff flow control is enabled."

	xOffByte := anInteger

]

{ #category : #accessing }
SerialPort >> xOnByte [

	^ xOnByte

]

{ #category : #accessing }
SerialPort >> xOnByte: anInteger [
	"Set the value of the XOn byte to be used if XOn/XOff flow control is enabled."

	xOnByte := anInteger

]
