"
A GTEventRecorderZipHandlerTest is a test class for testing the behavior of GTEventRecorderZipHandler
"
Class {
	#name : #GTEventRecorderZipHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'fileSystem',
		'handler'
	],
	#category : #'GT-EventRecorder-Server-Tests'
}

{ #category : #initialization }
GTEventRecorderZipHandlerTest >> setUp [
	super setUp.
	fileSystem := FileSystem memory.
	handler := GTEventRecorderZipHandler new.
	handler fileDirectory: fileSystem workingDirectory / 'files'.
	handler zipRootUrl: 'http://localhost/gt/zip/' asZnUrl.
]

{ #category : #initialization }
GTEventRecorderZipHandlerTest >> testZipUrl [
	self assert: handler zipRootUrl notNil.
	self assert: handler zipRootUrl asString equals: 'http://localhost/gt/zip/'
]
