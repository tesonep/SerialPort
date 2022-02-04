# Pharo SerialPort

I am a FFI implementation of the SerialPort interface for Pharo.

To install, just use: 

```Smalltalk
Metacello new
	baseline: 'SerialPort';
	repository: 'github://tesonep/SerialPort:main';
	load.
```

I am implemented using purely the FFI support in the image.
I am tested to run in Linux, OSX and Windows.

For an easy example of use check: ```SerialPortTest >> #testOpenArduino```.

Here there is a code snippet.

```Smalltalk
| stringToSend receivedString |
	sp := SerialPort new.
	sp baudRate: 38400.
	sp openPort: self portName.

	stringToSend := DateAndTime now printString.

	sp writeByteArray: stringToSend utf8Encoded.
	receivedString := (sp readByteArray: 10000) utf8Decoded.
	self assert: receivedString equals: stringToSend size printString ]
```
