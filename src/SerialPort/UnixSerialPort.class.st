"
I have the common behavior for the Linux and OSX serial port implementations.

"
Class {
	#name : #UnixSerialPort,
	#superclass : #Object,
	#instVars : [
		'fd',
		'portName'
	],
	#category : #SerialPort
}

{ #category : #testing }
UnixSerialPort class >> isAbstract [ 

	^ self == UnixSerialPort
]

{ #category : #constants }
UnixSerialPort class >> optionNOCTTY [
	
	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPort class >> optionNONBLOCK [
	
	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPort class >> optionRDWR [
	
	^ self subclassResponsibility 
]

{ #category : #operations }
UnixSerialPort >> changeSettings: serialPortSettings [ 
	
	| r |
	
	fd ifNil: [ self error: 'Cannot set settings in closed port' ].
	
	r := self ffiOnFD: fd set: serialPortSettings when: "TCSANOW" 0.
	
	r ~= 0 ifTrue: [ self error: 'Error setting attributes of port' ].

]

{ #category : #operations }
UnixSerialPort >> close [
	
	fd ifNotNil: [ self ffiClose: fd ].
	fd := nil.
]

{ #category : #'ffi - calls' }
UnixSerialPort >> ffiClose: anInteger [ 
	
	^ self ffiCall: #(int close(int anInteger))
]

{ #category : #library }
UnixSerialPort >> ffiLibrary [
	
	^ LibC
]

{ #category : #'ffi-calls' }
UnixSerialPort >> ffiOnFD: anFD set: serialPortSettings when: whenFlag [

	^ self ffiCall: #(int tcsetattr(int anFD, int whenFlag, UnixSerialPortSettings* serialPortSettings))
]

{ #category : #'ffi-calls' }
UnixSerialPort >> ffiOpen: aString withOptions: anInteger [ 

	^ self ffiCall: #(int open(char* aString, int anInteger))
]

{ #category : #'ffi - calls' }
UnixSerialPort >> ffiReadInto: aByteArray count: count from: aFD [ 

	^ self ffiCall: #(size_t read(int aFD, void* aByteArray, size_t count))
]

{ #category : #'ffi - calls' }
UnixSerialPort >> ffiWrite: aByteArray size: count into: aFD [

	self ffiCall: #(int write(int aFD, void* aByteArray, int count))
]

{ #category : #settings }
UnixSerialPort >> newDefaultSettings [ 

	^ self subclassResponsibility 
]

{ #category : #operations }
UnixSerialPort >> open [
	
	| options return |
	
	options := (self class optionRDWR bitOr: self class optionNONBLOCK) bitOr: self class optionNOCTTY.
	
	return := self ffiOpen: portName withOptions: options.

	return >= 0 
		ifTrue: [ fd := return ]
		ifFalse: [ fd := nil. self error: 'Error opening ' , portName ].
]

{ #category : #operations }
UnixSerialPort >> openPortWithBaudRate: baudRate stopBitsType: stopBitsType parityType: parityType dataBits: dataBits inFlowControlType: inFlowControlType outFlowControlType: outFlowControlType xOnByte: xOnByte xOffByte: xOffByte [
	
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
UnixSerialPort >> portId [
	
	^ portName
]

{ #category : #accessing }
UnixSerialPort >> portName: aString [ 
	
	portName := aString
]

{ #category : #operations }
UnixSerialPort >> readInto: aByteArray startingAt: starting count: count [ 

	| toRead r |
	fd ifNil: [ self error: 'Cannot read in closed port' ].
	
	toRead := ByteArray new: count.
	
	r := self ffiReadInto: toRead count: count from: fd.

	r = -1 ifTrue: [ self error: 'Error reading from serial port' ].
	
	aByteArray replaceFrom: starting to: starting + count - 1 with: toRead startingAt: 1.
	
	^ r 
		
]

{ #category : #operations }
UnixSerialPort >> writeFrom: byteArray startingAt: start count: count [

	| toWrite r |
	fd ifNil: [ self error: 'Cannot write in closed port' ].

	toWrite := byteArray copyFrom: start to: start + count - 1.

	r := self ffiWrite: toWrite size: count into: fd.
	
	r = -1 ifTrue: [ self error: 'Error writting to serial port' ].
	^ r 
	
	
]
