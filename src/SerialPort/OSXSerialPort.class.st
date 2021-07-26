Class {
	#name : #OSXSerialPort,
	#superclass : #Object,
	#instVars : [
		'portName',
		'fd'
	],
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

{ #category : #operations }
OSXSerialPort >> changeSettings: serialPortSettings [ 
	
	| r |
	
	fd ifNil: [ self error: 'Cannot set settings in closed port' ].
	
	r := self ffiOnFD: fd set: serialPortSettings when: "TCSANOW" 0.
	
	r ~= 0 ifTrue: [ self error: 'Error setting attributes of port' ].

]

{ #category : #operations }
OSXSerialPort >> close [
	
	fd ifNotNil: [ self ffiClose: fd ].
	fd := nil.
]

{ #category : #'ffi - calls' }
OSXSerialPort >> ffiClose: anInteger [ 
	
	^ self ffiCall: #(int close(int anInteger))
]

{ #category : #'ffi-calls' }
OSXSerialPort >> ffiOnFD: anFD set: serialPortSettings when: whenFlag [

	^ self ffiCall: #(int tcsetattr(int anFD, int whenFlag, OSXSerialPortSettings* serialPortSettings))
]

{ #category : #'ffi-calls' }
OSXSerialPort >> ffiOpen: aString withOptions: anInteger [ 

	^ self ffiCall: #(int open(char* aString, int anInteger))
]

{ #category : #'ffi - calls' }
OSXSerialPort >> ffiReadInto: aByteArray count: count from: aFD [ 

	^ self ffiCall: #(size_t read(int aFD, void* aByteArray, size_t count))
]

{ #category : #'ffi - calls' }
OSXSerialPort >> ffiWrite: aByteArray size: count into: aFD [

	self ffiCall: #(int write(int aFD, void* aByteArray, int count))
]

{ #category : #settings }
OSXSerialPort >> newDefaultSettings [
	
	^ OSXSerialPortSettings new
]

{ #category : #operations }
OSXSerialPort >> open [
	
	| options return |
	
	options := (self class optionRDWR bitOr: self class optionNONBLOCK) bitOr: self class optionNOCTTY.
	
	return := self ffiOpen: portName withOptions: options.

	return >= 0 
		ifTrue: [ fd := return ]
		ifFalse: [ fd := nil. self error: 'Error opening ' , portName ].
]

{ #category : #operations }
OSXSerialPort >> openPortWithBaudRate: baudRate stopBitsType: stopBitsType parityType: parityType dataBits: dataBits inFlowControlType: inFlowControlType outFlowControlType: outFlowControlType xOnByte: xOnByte xOffByte: xOffByte [
	
	| settings |

	settings := self newDefaultSettings.
	settings baudRate: baudRate.
	settings stopBits: stopBitsType.
	settings parity: parityType.
	settings dataBits: dataBits.
	settings inFlowControl: inFlowControlType.
	settings outFlowControl: outFlowControlType.
	settings xOnByte: xOnByte.
	settings xOffByte: xOffByte.

	[ self open.
	  self changeSettings: settings ] onErrorDo: [ :e | self close. e pass ].

	"Waiting to give time to the port to be open"	
	2 seconds wait.
]

{ #category : #accessing }
OSXSerialPort >> portId [
	
	^ portName
]

{ #category : #accessing }
OSXSerialPort >> portName: aString [ 
	
	portName := aString
]

{ #category : #operations }
OSXSerialPort >> readInto: aByteArray startingAt: starting count: count [ 

	| toRead r |
	fd ifNil: [ self error: 'Cannot read in closed port' ].
	
	toRead := ByteArray new: count.
	
	r := self ffiReadInto: toRead count: count from: fd.

	r = -1 ifTrue: [ self error: 'Error reading from serial port' ].
	
	aByteArray replaceFrom: starting to: starting + count - 1 with: toRead startingAt: 1.
	
	^ r 
		
]

{ #category : #operations }
OSXSerialPort >> writeFrom: byteArray startingAt: start count: count [

	| toWrite r |
	fd ifNil: [ self error: 'Cannot write in closed port' ].

	toWrite := byteArray copyFrom: start to: start + count - 1.

	r := self ffiWrite: toWrite size: count into: fd.
	
	r = -1 ifTrue: [ self error: 'Error writting to serial port' ].
	^ r 
	
	
]
