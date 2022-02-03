Class {
	#name : #Win32SerialPortDCB,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'MASK_fAbortOnError',
		'MASK_fBinary',
		'MASK_fDsrSensitivity',
		'MASK_fDtrControl',
		'MASK_fDummy2',
		'MASK_fErrorChar',
		'MASK_fInX',
		'MASK_fNull',
		'MASK_fOutX',
		'MASK_fOutxCtsFlow',
		'MASK_fOutxDsrFlow',
		'MASK_fParity',
		'MASK_fRtsControl',
		'MASK_fTXContinueOnXoff',
		'OFFSET_BAUDRATE',
		'OFFSET_BYTESIZE',
		'OFFSET_DCBLENGTH',
		'OFFSET_EOFCHAR',
		'OFFSET_ERRORCHAR',
		'OFFSET_EVTCHAR',
		'OFFSET_FLAGS',
		'OFFSET_PARITY',
		'OFFSET_STOPBITS',
		'OFFSET_WRESERVED',
		'OFFSET_WRESERVED1',
		'OFFSET_XOFFCHAR',
		'OFFSET_XOFFLIM',
		'OFFSET_XONCHAR',
		'OFFSET_XONLIM'
	],
	#category : #SerialPort
}

{ #category : #'field definition' }
Win32SerialPortDCB class >> fieldsDesc [

"self rebuildFieldAccessors"

	^ #(
  uint32 DCBlength
  uint32 BaudRate
  uint32 flags
  uint16 wReserved;
  uint16  XonLim;
  uint16  XoffLim;
  uint8  ByteSize;
  uint8  Parity;
  uint8  StopBits;
  char  XonChar;
  char  XoffChar;
  char  ErrorChar;
  char  EofChar;
  char  EvtChar;
  uint16 wReserved1
)
]

{ #category : #'field definition' }
Win32SerialPortDCB class >> initialize [

	MASK_fBinary := 1 << 31.
	MASK_fParity := 1 << 30.
	MASK_fOutxCtsFlow := 1 << 29.
	MASK_fOutxDsrFlow := 1 << 28.
	MASK_fDtrControl := 2r11 << 26.
	MASK_fDsrSensitivity := 1 << 25.
	MASK_fTXContinueOnXoff := 1 << 24.
	MASK_fOutX := 1 << 23.
	MASK_fInX := 1 << 22.
	MASK_fErrorChar := 1 << 21.
	MASK_fNull := 1 << 20.
	MASK_fRtsControl := 2r11 << 18.
	MASK_fAbortOnError := 1 << 17.
	MASK_fDummy2 := 2r11111111111111111.

]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> BaudRate [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_BAUDRATE
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> BaudRate: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_BAUDRATE put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> ByteSize [
	"This method was automatically generated"
	^handle unsignedByteAt: OFFSET_BYTESIZE
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> ByteSize: anObject [
	"This method was automatically generated"
	handle unsignedByteAt: OFFSET_BYTESIZE put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> DCBlength [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_DCBLENGTH
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> DCBlength: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_DCBLENGTH put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> EofChar [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_EOFCHAR
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> EofChar: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_EOFCHAR put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> ErrorChar [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_ERRORCHAR
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> ErrorChar: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_ERRORCHAR put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> EvtChar [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_EVTCHAR
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> EvtChar: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_EVTCHAR put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> Parity [
	"This method was automatically generated"
	^handle unsignedByteAt: OFFSET_PARITY
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> Parity: anObject [
	"This method was automatically generated"
	handle unsignedByteAt: OFFSET_PARITY put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> StopBits [
	"This method was automatically generated"
	^handle unsignedByteAt: OFFSET_STOPBITS
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> StopBits: anObject [
	"This method was automatically generated"
	handle unsignedByteAt: OFFSET_STOPBITS put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> XoffChar [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_XOFFCHAR
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> XoffChar: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_XOFFCHAR put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> XoffLim [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_XOFFLIM
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> XoffLim: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_XOFFLIM put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> XonChar [
	"This method was automatically generated"
	^handle unsignedCharAt: OFFSET_XONCHAR
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> XonChar: anObject [
	"This method was automatically generated"
	handle unsignedCharAt: OFFSET_XONCHAR put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> XonLim [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_XONLIM
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> XonLim: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_XONLIM put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> fInX: aValue [

	aValue = 1 
		ifTrue: [ self flags: self flags | MASK_fInX ]
		ifFalse: [ self flags: (self flags bitClear: MASK_fInX) ]

]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> fOutX: aValue [

	aValue = 1 
		ifTrue: [ self flags: self flags | MASK_fOutX ]
		ifFalse: [ self flags: (self flags bitClear: MASK_fOutX) ]

]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> flags [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_FLAGS
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> flags: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_FLAGS put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> wReserved [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_WRESERVED
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> wReserved1 [
	"This method was automatically generated"
	^handle unsignedShortAt: OFFSET_WRESERVED1
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> wReserved1: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_WRESERVED1 put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortDCB >> wReserved: anObject [
	"This method was automatically generated"
	handle unsignedShortAt: OFFSET_WRESERVED put: anObject
]
