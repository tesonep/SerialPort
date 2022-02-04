"
I am the Pharo mapping of the COMMTIMEOUTS structure as defined in: https://docs.microsoft.com/en-us/windows/win32/api/winbase/ns-winbase-commtimeouts
"
Class {
	#name : #Win32SerialPortCommTimeouts,
	#superclass : #FFIExternalStructure,
	#classVars : [
		'OFFSET_READINTERVALTIMEOUT',
		'OFFSET_READTOTALTIMEOUTCONSTANT',
		'OFFSET_READTOTALTIMEOUTMULTIPLIER',
		'OFFSET_WRITETOTALTIMEOUTCONSTANT',
		'OFFSET_WRITETOTALTIMEOUTMULTIPLIER'
	],
	#category : #SerialPort
}

{ #category : #'field definition' }
Win32SerialPortCommTimeouts class >> fieldsDesc [

"self rebuildFieldAccessors"

	^ #(
uint32 ReadIntervalTimeout;
uint32 ReadTotalTimeoutMultiplier;
uint32 ReadTotalTimeoutConstant;
uint32 WriteTotalTimeoutMultiplier;
uint32 WriteTotalTimeoutConstant;
)
]

{ #category : #'accessing - structure variables' }
Win32SerialPortCommTimeouts >> ReadIntervalTimeout [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_READINTERVALTIMEOUT
]

{ #category : #'accessing - structure variables' }
Win32SerialPortCommTimeouts >> ReadIntervalTimeout: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_READINTERVALTIMEOUT put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortCommTimeouts >> ReadTotalTimeoutConstant [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_READTOTALTIMEOUTCONSTANT
]

{ #category : #'accessing - structure variables' }
Win32SerialPortCommTimeouts >> ReadTotalTimeoutConstant: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_READTOTALTIMEOUTCONSTANT put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortCommTimeouts >> ReadTotalTimeoutMultiplier [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_READTOTALTIMEOUTMULTIPLIER
]

{ #category : #'accessing - structure variables' }
Win32SerialPortCommTimeouts >> ReadTotalTimeoutMultiplier: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_READTOTALTIMEOUTMULTIPLIER put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortCommTimeouts >> WriteTotalTimeoutConstant [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_WRITETOTALTIMEOUTCONSTANT
]

{ #category : #'accessing - structure variables' }
Win32SerialPortCommTimeouts >> WriteTotalTimeoutConstant: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_WRITETOTALTIMEOUTCONSTANT put: anObject
]

{ #category : #'accessing - structure variables' }
Win32SerialPortCommTimeouts >> WriteTotalTimeoutMultiplier [
	"This method was automatically generated"
	^handle unsignedLongAt: OFFSET_WRITETOTALTIMEOUTMULTIPLIER
]

{ #category : #'accessing - structure variables' }
Win32SerialPortCommTimeouts >> WriteTotalTimeoutMultiplier: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_WRITETOTALTIMEOUTMULTIPLIER put: anObject
]
