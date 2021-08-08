Class {
	#name : #LinuxSerialPortSettings,
	#superclass : #UnixSerialPortSettings,
	#classVars : [
		'ControlCharArray',
		'OFFSET_C_CC',
		'OFFSET_C_CFLAG',
		'OFFSET_C_IFLAG',
		'OFFSET_C_ISPEED',
		'OFFSET_C_LFLAG',
		'OFFSET_C_LINE',
		'OFFSET_C_OFLAG',
		'OFFSET_C_OSPEED',
		'cc_t',
		'speed_t',
		'tcflag_t'
	],
	#category : #SerialPort
}

{ #category : #'field definition' }
LinuxSerialPortSettings class >> fieldsDesc [
	
	<script:'self rebuildFieldAccessors'>
	
	^ #(
	tcflag_t         c_iflag
	tcflag_t         c_oflag
	tcflag_t         c_cflag
	tcflag_t         c_lflag
	cc_t 				  c_line		
	ControlCharArray c_cc
	speed_t          c_ispeed
	speed_t          c_ospeed)
]

{ #category : #initialization }
LinuxSerialPortSettings class >> initialize [

	<script: 'self initialize'>
	
	cc_t := 'uchar'.
	speed_t := 'uint32'.
	tcflag_t := 'uint32'.

	ControlCharArray := FFITypeArray ofType: cc_t size: 32.
]

{ #category : #parameters }
LinuxSerialPortSettings >> baudRateMap [

	^ { 
		  (0 -> 8r0).
		  (50 -> 8r1).
		  (75 -> 8r2).
		  (110 -> 8r3).
		  (134 -> 8r4).
		  (150 -> 8r5).
		  (200 -> 8r6).
		  (300 -> 8r7).
		  (600 -> 8r10).
		  (1200 -> 8r11).
		  (1800 -> 8r12).
		  (2400 -> 8r13).
		  (4800 -> 8r14).
		  (9600 -> 8r15).
		  (19200 -> 8r16).
		  (38400 -> 8r17).
		  (57600 -> 8r0010001).
		  (115200 -> 8r0010002).
		  (230400 -> 8r0010003).
		  (460800 -> 8r0010004).
		  (500000 -> 8r0010005).
		  (576000 -> 8r0010006).
		  (921600 -> 8r0010007).
		  (1000000 -> 8r0010010).
		  (1152000 -> 8r0010011).
		  (1500000 -> 8r0010012).
		  (2000000 -> 8r0010013).
		  (2500000 -> 8r0010014).
		  (3000000 -> 8r0010015).
		  (3500000 -> 8r0010016).
		  (4000000 -> 8r0010017) } asDictionary
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_cc [
	"This method was automatically generated"
	^(FFITypeArray ofType: #FFIUInt8 size: 32) fromHandle: (handle copyFrom: OFFSET_C_CC to: OFFSET_C_CC + 31)
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_cc: anObject [
	"This method was automatically generated"
	handle replaceFrom: OFFSET_C_CC to: OFFSET_C_CC + 31 with: anObject getHandle startingAt: 1
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_cflag [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_C_CFLAG
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_cflag: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_C_CFLAG put: anObject
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_iflag [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_C_IFLAG
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_iflag: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_C_IFLAG put: anObject
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_ispeed [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_C_ISPEED
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_ispeed: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_C_ISPEED put: anObject
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_lflag [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_C_LFLAG
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_lflag: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_C_LFLAG put: anObject
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_line [
	"This method was automatically generated"
	^handle unsignedByteAt: OFFSET_C_LINE
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_line: anObject [
	"This method was automatically generated"
	handle unsignedByteAt: OFFSET_C_LINE put: anObject
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_oflag [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_C_OFLAG
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_oflag: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_C_OFLAG put: anObject
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_ospeed [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_C_OSPEED
]

{ #category : #'accessing - structure variables' }
LinuxSerialPortSettings >> c_ospeed: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_C_OSPEED put: anObject
]

{ #category : #'ffi - calls' }
LinuxSerialPortSettings >> cfgetospeed [

	^ self ffiCall: 'speed_t cfgetospeed(self)'
]

{ #category : #'ffi - calls' }
LinuxSerialPortSettings >> cfsetispeed: aValue [

	^ self ffiCall: 'int cfsetispeed(self, speed_t aValue)'
]

{ #category : #'ffi - calls' }
LinuxSerialPortSettings >> cfsetospeed: aValue [

	^ self ffiCall: 'int cfsetospeed(self, speed_t aValue)'
]

{ #category : #constants }
LinuxSerialPortSettings >> constCREAD [

	^ 	"CREAD	"	8r0000200
		

]

{ #category : #constants }
LinuxSerialPortSettings >> constCSIZE [

	^ "CSIZE" 8r0000060
]

{ #category : #constants }
LinuxSerialPortSettings >> constCSTOPB [

	^ "CSTOPB" 8r0000100

]

{ #category : #constants }
LinuxSerialPortSettings >> constIGNBRK [

	^ "IGNBRK	" 8r0000001
]

{ #category : #constants }
LinuxSerialPortSettings >> constIGNPAR [

	^ "IGNPAR"	8r0000004
]

{ #category : #constants }
LinuxSerialPortSettings >> constIXANY [

	^ "IXANY" 8r0004000
]

{ #category : #constants }
LinuxSerialPortSettings >> constIXOFF [

	^ "IXOFF"		8r0010000
]

{ #category : #constants }
LinuxSerialPortSettings >> constIXON [

	^ "IXON" 8r0002000
]

{ #category : #constants }
LinuxSerialPortSettings >> constPARENB [

	^ "PARENB	" 8r0000400 
	
]

{ #category : #constants }
LinuxSerialPortSettings >> constPARODD [

	^ "PARODD" 	8r0001000
]

{ #category : #constants }
LinuxSerialPortSettings >> constVSTART [

	^ "VSTART" 8

]

{ #category : #constants }
LinuxSerialPortSettings >> constVSTOP [

	^ "VSTOP" 9

]

{ #category : #parameters }
LinuxSerialPortSettings >> convertBaudRate: aValue [

	^ self baudRateMap at: aValue
]

{ #category : #parameters }
LinuxSerialPortSettings >> convertFromBaudRate: aValue [

	^ self baudRateMap keyAtValue: aValue
]

{ #category : #parameters }
LinuxSerialPortSettings >> dataBitsMap [

	^ { 5 ->   "CS5"	8r0000000.
		 6 ->	  "CS6"	8r0000020.
		 7 ->   "CS7"	8r0000040.
		 8 ->   "CS8"	8r0000060} asDictionary 
]

{ #category : #parameters }
LinuxSerialPortSettings >> validBaudRates [

	^ self baudRateMap keys
]
