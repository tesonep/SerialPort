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
