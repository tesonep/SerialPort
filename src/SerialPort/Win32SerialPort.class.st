Class {
	#name : #Win32SerialPort,
	#superclass : #Object,
	#instVars : [
		'portName',
		'handle'
	],
	#classVars : [
		'BOOLEAN32',
		'UINT32_HOLDER'
	],
	#category : #SerialPort
}

{ #category : #initialization }
Win32SerialPort class >> initialize [

	BOOLEAN32 := FFIBoolean32.
	UINT32_HOLDER := FFIExternalValueHolder ofType: 'uint32' 
]

{ #category : #'private - operations' }
Win32SerialPort >> close [

	handle ifNotNil: [ 
		self primCloseHandle: handle.
		handle := nil ]
]

{ #category : #'private - operations' }
Win32SerialPort >> open [

	| lastError |
	handle := self
		          primCreateFileW: portName asWin32WideString
		          _: 16r80000000 | 16r40000000 "GENERIC_READ | GENERIC_WRITE"
		          _: 0   "must be opened with exclusive-access"
		          _: nil "default security attributes"
		          _: 3 "OPEN_EXISTING" "must use OPEN_EXISTING"
		          _: 0 "not overlapped I/O"
		          _: nil "hTemplate must be NULL for comm devices".
	
	"If all the values are 255 we are in an error condition"
	(handle allSatisfy: [ :e | e = 255 ]) 
		ifTrue: [ 
			lastError := OSPlatform current lastError.
			handle := nil.
			self error: 'Calling function CreateFileW returned with lastError: ' , lastError printString]
]

{ #category : #operations }
Win32SerialPort >> openPortWithBaudRate: baudRate stopBitsType: stopBits parityType: parityType dataBits: dataBytes inFlowControlType: inFlowControlType outFlowControlType: outFlowControlType xOnByte: xOnByte xOffByte: sOffByte [

	self open.
	
	[ 
		self
			setBaudRate: baudRate
			stopBitsType: stopBits
			parityType: parityType
			dataBits: dataBytes
			inFlowControlType: inFlowControlType
			outFlowControlType: outFlowControlType
			xOnByte: xOnByte
			xOffByte: sOffByte ] 
		onErrorDo: [ :e | 
			self close.
			e pass ]
]

{ #category : #accessing }
Win32SerialPort >> portName: aString [ 
	
	portName := aString
]

{ #category : #primitives }
Win32SerialPort >> primCloseHandle: hObject [

	^ self
		  ffiCall: #( BOOLEAN32 CloseHandle (void* hObject ))
		  module: #Kernel32
]

{ #category : #primitives }
Win32SerialPort >> primCreateFileW: lpFileName _: dwDesiredAccess _: dwShareMode _: lpSecurityAttributes _: dwCreationDisposition _: dwFlagsAndAttributes _: hTemplateFile [ 

	^ self ffiCall: #(void* CreateFileW(
						Win32WideString lpFileName,
  						uint32                 dwDesiredAccess,
  						uint32                 dwShareMode,
  						void*						lpSecurityAttributes,
  						uint32                 dwCreationDisposition,
  						uint32                 dwFlagsAndAttributes,
  						void*                hTemplateFile)) module: #Kernel32
]

{ #category : #primitives }
Win32SerialPort >> primGetCommState: hFile _: lpDCB [

	^ self ffiCall: #(BOOLEAN32 GetCommState(
										void* hFile,
										Win32SerialPortDCB* lpDCB
									)) module: #Kernel32.

]

{ #category : #primitives }
Win32SerialPort >> primReadFile: hFile _: lpBuffer _: nNumberOfBytesToRead _: lpNumberOfBytesRead _: lpOverlapped [ 

	^ self ffiCall: #(BOOLEAN32 ReadFile(
								void*       hFile,
								void*       lpBuffer,
								uint32        nNumberOfBytesToRead,
								uint32*      lpNumberOfBytesRead,
								void* lpOverlapped)) module: #Kernel32
]

{ #category : #primitives }
Win32SerialPort >> primSetCommState: hFile _: lpDCB [

	^ self ffiCall: #(BOOLEAN32 SetCommState(
										void* hFile,
										Win32SerialPortDCB* lpDCB
									)) module: #Kernel32.

]

{ #category : #primitives }
Win32SerialPort >> primWriteFile: hFile _: lpBuffer _: nNumberOfBytesToWrite _: lpNumberOfBytesWritten _: lpOverlapped [ 

	^ self ffiCall: #(BOOLEAN32 WriteFile(
											void*        hFile,
											void*        lpBuffer,
											uint32       nNumberOfBytesToWrite,
											uint32*      lpNumberOfBytesWritten,
											void* lpOverlapped)) module: #Kernel32
]

{ #category : #operations }
Win32SerialPort >> readInto: aByteArray startingAt: starting count: count [ 

	| toRead readedData |
	
	handle ifNil: [ self error: 'Cannot read in closed port' ].
	
	toRead := ByteArray new: count.
	readedData := UINT32_HOLDER new value: 0; yourself.
	
	(self primReadFile: handle _: toRead _: count _: readedData _: nil ) 
		ifFalse: [ self error: 'Error reading from serial port' ].
	
	aByteArray replaceFrom: starting to: starting + readedData value - 1 with: toRead startingAt: 1.
	
	^ readedData value
]

{ #category : #operations }
Win32SerialPort >> setBaudRate: baudRate stopBitsType: stopBits parityType: parityType dataBits: dataBytes inFlowControlType: inFlowControlType outFlowControlType: outFlowControlType xOnByte: xOnByte xOffByte: sOffByte [

	| dcb lastError |
	
	dcb := Win32SerialPortDCB new.
	
	(self primGetCommState: handle _: dcb)
		ifFalse: [ 
			lastError := OSPlatform current lastError.
			self error: 'Could not read the state of the port:' , lastError printString ].
		
	dcb BaudRate: baudRate.
	dcb StopBits: stopBits.
	dcb Parity: parityType.
	dcb ByteSize: dataBytes.
	dcb fInX: inFlowControlType.
	dcb fOutX: outFlowControlType.
	dcb XonChar: xOnByte asCharacter.
	dcb XoffChar: sOffByte asCharacter.

	(self primSetCommState: handle _: dcb)
		ifFalse: [ 
			lastError := OSPlatform current lastError.
			self error: 'Could not set the state of the port:' , lastError printString ].
	
]

{ #category : #operations }
Win32SerialPort >> writeFrom: byteArray startingAt: start count: count [

	| toWrite writedData |

	handle ifNil: [ self error: 'Cannot write in closed port' ].

	toWrite := byteArray copyFrom: start to: start + count - 1.
	writedData := UINT32_HOLDER new value: 0; yourself.
	
	(self primWriteFile: handle _: toWrite _: count _: writedData _: nil)
		ifFalse: [ self error: 'Error writting to serial port' ].
	
	^ writedData value
]
