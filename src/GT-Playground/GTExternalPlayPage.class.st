"
I am a playground page that maintains a connection to a file outside of the cache folder of the playground.
"
Class {
	#name : #GTExternalPlayPage,
	#superclass : #GTPlayPage,
	#classInstVars : [
		'aTitle'
	],
	#category : #'GT-Playground'
}

{ #category : #private }
GTExternalPlayPage class >> askForFileNameToOpen [
	"Ask user for file name to load content from"
	^ UIManager default
			chooseFullFileNameMatching: nil 
			label: 'Choose file to open in the workspace' translated
]

{ #category : #private }
GTExternalPlayPage class >> askForFileNameToSave: suggestedFileName [
	"Ask user for the name of the file to save workspace content to. Use the given file name as the initial answer"
	^ UIManager default
			request: 'Enter file name to save the workspace to' translated 
			initialAnswer: suggestedFileName
]

{ #category : #'instance creation' }
GTExternalPlayPage class >> externalPageForContent: aString withPossibleTitles: anArray [
	| fileName |
	
	aString ifEmpty: [ ^ nil ].
	fileName := self askForFileNameToSave: ((anArray detect: [:each | each ~= 'Playground'] ifNone: [ 'Untitled' ] ), '.', self fileExtension).
	fileName ifNil: [ ^ nil ].
	fileName asFileReference ensureCreateFile.
	^ (self fromFileName: fileName)
		saveContent: aString;
		yourself
	
		
]

{ #category : #'accessing-dynamic' }
GTExternalPlayPage class >> fileExtension [
	^ 'ws'
]

{ #category : #'instance creation' }
GTExternalPlayPage class >> fromFileName: aFileName [

	aFileName isEmptyOrNil ifTrue: [ ^ nil ]. "cancel the action"
	^ self fromFileReference: aFileName asFileReference
]

{ #category : #'instance creation' }
GTExternalPlayPage class >> fromFileReference [

	^ self fromFileName: self askForFileNameToOpen
]

{ #category : #'instance creation' }
GTExternalPlayPage class >> fromFileReference: aFileReference [
	
	^ (super fromFileReference: aFileReference)
		fileName: aFileReference fullName;
		yourself
]

{ #category : #'accessing-dynamic' }
GTExternalPlayPage >> fileDirectory [
	^ nil
]

{ #category : #'accessing-dynamic' }
GTExternalPlayPage >> fileReference [
	^ self fileName asFileReference
]

{ #category : #testing }
GTExternalPlayPage >> isInteresting [
	^ false
]

{ #category : #'accessing-dynamic' }
GTExternalPlayPage >> title [

	^ self fileReference basenameWithoutExtension
]
