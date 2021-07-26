Class {
	#name : #OSXSerialPortSettings,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'ControlCharArray',
		'OFFSET_C_CC',
		'OFFSET_C_CFLAG',
		'OFFSET_C_IFLAG',
		'OFFSET_C_ISPEED',
		'OFFSET_C_LFLAG',
		'OFFSET_C_OFLAG',
		'OFFSET_C_OSPEED'
	],
	#category : #SerialPort
}

{ #category : #'field definition' }
OSXSerialPortSettings class >> fieldsDesc [
	
	<script:'self rebuildFieldAccessors'>
	
	^ #(
	uint64           c_iflag
	uint64           c_oflag
	uint64           c_cflag
	uint64           c_lflag
	ControlCharArray c_cc
	uint64           c_ispeed
	uint64           c_ospeed)
]

{ #category : #'field definition' }
OSXSerialPortSettings class >> initialize [

	<script: 'self initialize'>
	
	ControlCharArray := FFITypeArray ofType: 'char' size: 20.
]

{ #category : #'instance creation' }
OSXSerialPortSettings class >> new [ 

	^ super new
		initializeDefaultValues;
		yourself
]

{ #category : #accessing }
OSXSerialPortSettings >> baudRate [

	^ self cfgetospeed
]

{ #category : #accessing }
OSXSerialPortSettings >> baudRate: anObject [

	self assert:
		(#( 0 50 75 110 134 150 200 300 600 1200 1800 2400 4800 9600 19200
		    38400 7200 14400 28800 57600 76800 115200 230400 ) includes:
			 anObject).

	(self cfsetospeed: anObject) ~= 0 ifTrue: [self error: 'Cannot set speed'].
	(self cfsetispeed: anObject) ~= 0 ifTrue: [self error: 'Cannot set speed'].
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_cc [
	"This method was automatically generated"
	^(FFITypeArray ofType: #FFICharacterType size: 20) fromHandle: (handle copyFrom: OFFSET_C_CC to: OFFSET_C_CC + 19)
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_cc: anObject [
	"This method was automatically generated"
	handle replaceFrom: OFFSET_C_CC to: OFFSET_C_CC + 19 with: anObject getHandle startingAt: 1
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_cflag [
	"This method was automatically generated"
	^handle unsignedLongLongAt: OFFSET_C_CFLAG
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_cflag: anObject [
	"This method was automatically generated"
	handle unsignedLongLongAt: OFFSET_C_CFLAG put: anObject
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_iflag [
	"This method was automatically generated"
	^handle unsignedLongLongAt: OFFSET_C_IFLAG
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_iflag: anObject [
	"This method was automatically generated"
	handle unsignedLongLongAt: OFFSET_C_IFLAG put: anObject
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_ispeed [
	"This method was automatically generated"
	^handle unsignedLongLongAt: OFFSET_C_ISPEED
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_ispeed: anObject [
	"This method was automatically generated"
	handle unsignedLongLongAt: OFFSET_C_ISPEED put: anObject
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_lflag [
	"This method was automatically generated"
	^handle unsignedLongLongAt: OFFSET_C_LFLAG
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_lflag: anObject [
	"This method was automatically generated"
	handle unsignedLongLongAt: OFFSET_C_LFLAG put: anObject
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_oflag [
	"This method was automatically generated"
	^handle unsignedLongLongAt: OFFSET_C_OFLAG
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_oflag: anObject [
	"This method was automatically generated"
	handle unsignedLongLongAt: OFFSET_C_OFLAG put: anObject
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_ospeed [
	"This method was automatically generated"
	^handle unsignedLongLongAt: OFFSET_C_OSPEED
]

{ #category : #'accessing - structure variables' }
OSXSerialPortSettings >> c_ospeed: anObject [
	"This method was automatically generated"
	handle unsignedLongLongAt: OFFSET_C_OSPEED put: anObject
]

{ #category : #'ffi - calls' }
OSXSerialPortSettings >> cfgetospeed [

	^ self ffiCall: 'uint64 cfgetospeed(self)'
]

{ #category : #'ffi - calls' }
OSXSerialPortSettings >> cfsetispeed: aValue [

	^ self ffiCall: 'int cfsetispeed(self, uint64 aValue)'
]

{ #category : #'ffi - calls' }
OSXSerialPortSettings >> cfsetospeed: aValue [

	^ self ffiCall: 'int cfsetospeed(self, uint64 aValue)'
]

{ #category : #accessing }
OSXSerialPortSettings >> dataBits [

	| flags |
	
	flags := self c_cflag.
	flags := flags bitAnd: 16r00000300.
	^ self dataBitsMap keyAtValue: flags.
]

{ #category : #accessing }
OSXSerialPortSettings >> dataBits: anObject [

	| flags |
	
	flags := self c_cflag.
	"Clear the data bits"
	flags := flags bitClear: 16r00000300.
	
	flags := flags bitOr: (self dataBitsMap at: anObject).
	
	self c_cflag: flags.
	
]

{ #category : #accessing }
OSXSerialPortSettings >> dataBitsMap [

	^ {5 -> 16r00000000. 6 -> 16r00000100. 7 -> 16r00000200. 8 -> 16r00000300} asDictionary.
]

{ #category : #accessing }
OSXSerialPortSettings >> inFlowControl [

	"0=none, 1=XOn/XOff"

	^ (self c_iflag bitAnd: "IXOFF" 16r00000400) = "IXOFF" 16r00000400 ifTrue: [ 1 ] ifFalse: [ 0 ]

]

{ #category : #accessing }
OSXSerialPortSettings >> inFlowControl: anObject [

	"0=none, 1=XOn/XOff"

	| flags |
	flags := self c_iflag.
	flags := flags bitClear: ("IXOFF" 16r00000400 bitOr: "IXANY" 16r00000800).

	anObject = 1 ifTrue: [ flags := flags bitOr: "IXOFF" 16r00000400 ].

	self c_iflag: flags.

]

{ #category : #accessing }
OSXSerialPortSettings >> initializeDefaultValues [

	"ignore BREAK condition, ignore (discard) parity errors"
	self c_iflag: "IGNBRK | IGNPAR" (16r00000001 bitOr: 16r00000004).
	self c_cflag: "CREAD: enable receiver" 16r00000800.
]

{ #category : #accessing }
OSXSerialPortSettings >> outFlowControl [

	"0=none, 1=XOn/XOff"

	^ (self c_iflag bitAnd: "IXON" 16r00000200) = "IXON" 16r00000200 ifTrue: [ 1 ] ifFalse: [ 0 ]

]

{ #category : #accessing }
OSXSerialPortSettings >> outFlowControl: anObject [

	"0=none, 1=XOn/XOff"

	| flags |
	flags := self c_iflag.
	flags := flags bitClear: ("IXON" 16r00000200 bitOr: "IXANY" 16r00000800).

	anObject = 1 ifTrue: [ flags := flags bitOr: "IXON" 16r00000200 ].

	self c_iflag: flags.

]

{ #category : #accessing }
OSXSerialPortSettings >> parity [
	"parityType 0=no, 1=odd, 2=even"

	| flags |
	flags := self c_cflag.
	flags := flags bitAnd: ("PARENB" 16r00001000 bitOr: "PARODD" 16r00002000).
	
	^ self parityMap keyAtValue: flags.

]

{ #category : #accessing }
OSXSerialPortSettings >> parity: anObject [
	"parityType 0=no, 1=odd, 2=even"

	| flags |
	
	flags := self c_cflag.
	flags := flags bitClear: ("PARENB" 16r00001000 bitOr: "PARODD" 16r00002000).
	flags := flags bitOr: (self parityMap at: anObject).

	self c_cflag: flags.
	

]

{ #category : #accessing }
OSXSerialPortSettings >> parityMap [

	^ { 0 -> 0. 1 -> ("PARENB" 16r00001000 bitOr: "PARODD" 16r00002000). 2 -> "PARENB" 16r00001000} asDictionary 

]

{ #category : #printing }
OSXSerialPortSettings >> printOn: aStream [

	super printOn: aStream.

	aStream print: { 
			(#baudRate -> self baudRate).
			(#dataBits -> self dataBits).
			(#parity -> self parity).
			(#stopBits -> self stopBits).
			(#inFlowControl -> self inFlowControl).
			(#outFlowControl -> self outFlowControl) }
]

{ #category : #accessing }
OSXSerialPortSettings >> stopBits [

	| flags |

	flags := self c_cflag.
		
	^ (flags bitAnd: 16r00000400) = 16r00000400 "CSTOPB"
		ifTrue: [ 2 ]
		ifFalse: [ 1 ].

]

{ #category : #accessing }
OSXSerialPortSettings >> stopBits: anObject [

	| flags |
	self assert: (#(1 2) includes: anObject).

	flags := self c_cflag.
		
	anObject = 1 
		ifTrue: [ flags := flags bitClear: "CSTOPB" 16r00000400 ]
		ifFalse: [ flags := flags bitOr: "CSTOPB" 16r00000400 ].
		
	self c_cflag: flags.
]

{ #category : #accessing }
OSXSerialPortSettings >> xOffByte [

	^ self c_cc at: 13 "VSTOP" + 1.

]

{ #category : #accessing }
OSXSerialPortSettings >> xOffByte: anInteger [

	| controlChars |
	controlChars := self c_cc.
	controlChars at: 13 "VSTOP" + 1 put: anInteger.

	self c_cc: controlChars.

]

{ #category : #accessing }
OSXSerialPortSettings >> xOnByte [

	^ self c_cc at: 12 "VSTART" + 1.

]

{ #category : #accessing }
OSXSerialPortSettings >> xOnByte: anInteger [

	| controlChars |
	controlChars := self c_cc.
	controlChars at: 12 "VSTART" + 1 put: anInteger.

	self c_cc: controlChars.

]
