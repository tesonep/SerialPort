"
I am the struct definition and values for the OSX Serial port Settings
"
Class {
	#name : #OSXSerialPortSettings,
	#superclass : #UnixSerialPortSettings,
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

{ #category : #constants }
OSXSerialPortSettings >> constCREAD [

	^ 16r00000800 "CREAD: enable receiver"
]

{ #category : #constants }
OSXSerialPortSettings >> constCSIZE [

	^ 16r00000300 "CSIZE"
]

{ #category : #constants }
OSXSerialPortSettings >> constCSTOPB [

	^ 16r00000400 "CSTOPB"
]

{ #category : #constants }
OSXSerialPortSettings >> constIGNBRK [

	^ 16r00000001 "IGNBRK"
]

{ #category : #constants }
OSXSerialPortSettings >> constIGNPAR [

	^ 16r00000004 "IGNPAR"
]

{ #category : #constants }
OSXSerialPortSettings >> constIXANY [

	^ 16r00000800 "IXANY"
]

{ #category : #constants }
OSXSerialPortSettings >> constIXOFF [

	^ 16r00000400 "IXOFF"
]

{ #category : #constants }
OSXSerialPortSettings >> constIXON [

	^ 16r00000200 "IXON"
]

{ #category : #constants }
OSXSerialPortSettings >> constPARENB [

	^ 16r00001000 "PARENB"
]

{ #category : #constants }
OSXSerialPortSettings >> constPARODD [

	^ 16r00002000 "PARODD"
]

{ #category : #constants }
OSXSerialPortSettings >> constVSTART [

	^ 12 "VSTART"
]

{ #category : #constants }
OSXSerialPortSettings >> constVSTOP [

	^ 13 "VSTOP"
]

{ #category : #parameters }
OSXSerialPortSettings >> convertBaudRate: aValue [
	"OSX passes directly an integer with the speed"
	^ aValue
]

{ #category : #parameters }
OSXSerialPortSettings >> convertFromBaudRate: aValue [
	"OSX passes directly an integer with the speed"
	^ aValue
]

{ #category : #parameters }
OSXSerialPortSettings >> dataBitsMap [

	^ {5 -> 16r00000000. 6 -> 16r00000100. 7 -> 16r00000200. 8 -> 16r00000300} asDictionary.
]

{ #category : #parameters }
OSXSerialPortSettings >> validBaudRates [

	^ #( 0 50 75 110 134 150 200 300 600 1200 1800 2400 4800 9600 19200
	     38400 7200 14400 28800 57600 76800 115200 230400 )
]
