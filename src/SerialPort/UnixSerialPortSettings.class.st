Class {
	#name : #UnixSerialPortSettings,
	#superclass : #FFIExternalStructure,
	#category : #SerialPort
}

{ #category : #testing }
UnixSerialPortSettings class >> isAbstract [ 

	^ self == UnixSerialPortSettings 
]

{ #category : #accessing }
UnixSerialPortSettings >> baudRate [

	^ self convertFromBaudRate: self cfgetospeed
]

{ #category : #accessing }
UnixSerialPortSettings >> baudRate: anObject [

	| aValue |
	self assert: (self validBaudRates includes: anObject).

	aValue := self convertBaudRate: anObject.

	(self cfsetospeed: aValue) ~= 0 ifTrue: [ 
		self error: 'Cannot set speed' ].
	(self cfsetispeed: aValue) ~= 0 ifTrue: [ 
		self error: 'Cannot set speed' ]
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_cc [

	^ self subclassResponsibility 
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_cc: aValue [

	^ self subclassResponsibility 
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_cflag [

	^ self subclassResponsibility 
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_cflag: aValue [

	^ self subclassResponsibility 
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_iflag [

	^ self subclassResponsibility 
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_iflag: aValue [

	^ self subclassResponsibility 
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_ispeed [
	^ self subclassResponsibility
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_ispeed: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_lflag [
	^ self subclassResponsibility
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_lflag: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_oflag [
	^ self subclassResponsibility
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_oflag: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_ospeed [
	^ self subclassResponsibility
]

{ #category : #'accessing - structure variables' }
UnixSerialPortSettings >> c_ospeed: arg1 [ 
	^ self subclassResponsibility
]

{ #category : #'ffi - calls' }
UnixSerialPortSettings >> cfgetospeed [

	^ self subclassResponsibility 
]

{ #category : #'ffi - calls' }
UnixSerialPortSettings >> cfsetispeed: aValue [

	^ self subclassResponsibility 
]

{ #category : #'ffi - calls' }
UnixSerialPortSettings >> cfsetospeed: aValue [

	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPortSettings >> constCREAD [

	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPortSettings >> constCSIZE [

	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPortSettings >> constCSTOPB [

	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPortSettings >> constIGNBRK [

	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPortSettings >> constIGNPAR [

	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPortSettings >> constIXANY [

	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPortSettings >> constIXOFF [

	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPortSettings >> constIXON [

	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPortSettings >> constPARENB [

	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPortSettings >> constPARODD [

	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPortSettings >> constVSTART [

	^ self subclassResponsibility 
]

{ #category : #constants }
UnixSerialPortSettings >> constVSTOP [

	^ self subclassResponsibility 
]

{ #category : #parameters }
UnixSerialPortSettings >> convertBaudRate: aValue [

	^ self subclassResponsibility 
]

{ #category : #parameters }
UnixSerialPortSettings >> convertFromBaudRate: aValue [

	^ self subclassResponsibility 
]

{ #category : #accessing }
UnixSerialPortSettings >> dataBits [

	| flags |
	flags := self c_cflag.
	flags := flags bitAnd: self constCSIZE.
	^ self dataBitsMap keyAtValue: flags
]

{ #category : #accessing }
UnixSerialPortSettings >> dataBits: anObject [

	| flags |
	flags := self c_cflag.
	"Clear the data bits"
	flags := flags bitClear: self constCSIZE.

	flags := flags bitOr: (self dataBitsMap at: anObject).

	self c_cflag: flags
]

{ #category : #parameters }
UnixSerialPortSettings >> dataBitsMap [

	^ self subclassResponsibility 
]

{ #category : #library }
UnixSerialPortSettings >> ffiLibrary [
	
	^ LibC
]

{ #category : #accessing }
UnixSerialPortSettings >> inFlowControl [

	"0=none, 1=XOn/XOff"

	^ (self c_iflag bitAnd: self constIXOFF) = self constIXOFF
		  ifTrue: [ 1 ]
		  ifFalse: [ 0 ]
]

{ #category : #accessing }
UnixSerialPortSettings >> inFlowControl: anObject [

	"0=none, 1=XOn/XOff"

	| flags |
	flags := self c_iflag.
	flags := flags bitClear: (self constIXOFF bitOr: self constIXANY).

	anObject = 1 ifTrue: [ flags := flags bitOr: self constIXOFF ].

	self c_iflag: flags
]

{ #category : #accessing }
UnixSerialPortSettings >> initializeDefaultValues [

	"ignore BREAK condition, ignore (discard) parity errors"

	self c_iflag: (self constIGNBRK bitOr: self constIGNPAR).
	self c_cflag: self constCREAD "CREAD: enable receiver"
]

{ #category : #accessing }
UnixSerialPortSettings >> outFlowControl [

	"0=none, 1=XOn/XOff"

	^ (self c_iflag bitAnd: self constIXON) = self constIXON
		  ifTrue: [ 1 ]
		  ifFalse: [ 0 ]
]

{ #category : #accessing }
UnixSerialPortSettings >> outFlowControl: anObject [

	"0=none, 1=XOn/XOff"

	| flags |
	flags := self c_iflag.
	flags := flags bitClear: (self constIXON bitOr: self constIXANY).

	anObject = 1 ifTrue: [ flags := flags bitOr: self constIXON ].

	self c_iflag: flags
]

{ #category : #accessing }
UnixSerialPortSettings >> parity [

	"parityType 0=no, 1=odd, 2=even"

	| flags |
	flags := self c_cflag.
	flags := flags bitAnd: (self constPARENB bitOr: self constPARODD).

	^ self parityMap keyAtValue: flags
]

{ #category : #accessing }
UnixSerialPortSettings >> parity: anObject [

	"parityType 0=no, 1=odd, 2=even"

	| flags |
	flags := self c_cflag.
	flags := flags bitClear:
		         (self constPARENB bitOr: self constPARODD).
	flags := flags bitOr: (self parityMap at: anObject).

	self c_cflag: flags
]

{ #category : #parameters }
UnixSerialPortSettings >> parityMap [

	^ {  (0 -> 0).
		  (1 -> (self constPARENB bitOr: self constPARODD)).
		  (2 -> self constPARENB) } asDictionary
]

{ #category : #printing }
UnixSerialPortSettings >> printOn: aStream [

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
UnixSerialPortSettings >> stopBits [

	| flags |
	flags := self c_cflag.

	^ (flags bitAnd: self constCSTOPB) = self constCSTOPB
		  ifTrue: [ 2 ]
		  ifFalse: [ 1 ]
]

{ #category : #accessing }
UnixSerialPortSettings >> stopBits: anObject [

	| flags |
	self assert: (#( 1 2 ) includes: anObject).

	flags := self c_cflag.

	flags := anObject = 1
		ifTrue: [ flags bitClear: self constCSTOPB ]
		ifFalse: [ flags bitOr: self constCSTOPB ].

	self c_cflag: flags
]

{ #category : #parameters }
UnixSerialPortSettings >> validBaudRates [

	^ self subclassResponsibility 
]

{ #category : #accessing }
UnixSerialPortSettings >> xOffByte [

	^ self c_cc at: self constVSTOP + 1
]

{ #category : #accessing }
UnixSerialPortSettings >> xOffByte: anInteger [

	| controlChars |
	controlChars := self c_cc.
	controlChars at: self constVSTOP + 1 put: anInteger. 

	self c_cc: controlChars
]

{ #category : #accessing }
UnixSerialPortSettings >> xOnByte [

	^ self c_cc at: self constVSTART + 1
]

{ #category : #accessing }
UnixSerialPortSettings >> xOnByte: anInteger [

	| controlChars |
	controlChars := self c_cc.
	controlChars at: self constVSTART + 1 put: anInteger.

	self c_cc: controlChars
]
