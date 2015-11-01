Class {
	#name : #GTATool,
	#superclass : #Object,
	#classInstVars : [
		'semaphore',
		'process',
		'spotterExtensionTitles'
	],
	#category : #'GT-Spotter-EventRecorder-Analysis-Utilities'
}

{ #category : #private }
GTATool class >> checkProcess [
	process isComplete ifTrue: [ semaphore signal ].

]

{ #category : #cleanup }
GTATool class >> cleanUp [
	super cleanUp.
	self resetSpotterExtensionTitles.
]

{ #category : #defaults }
GTATool class >> defaultDownloadDirectory [
	^ FileSystem disk workingDirectory
]

{ #category : #defaults }
GTATool class >> defaultDownloadFilename [
	^ self defaultDownloadDirectory / 'gt-events.tar.gz'
]

{ #category : #defaults }
GTATool class >> defaultEventsDirectory [
	^ self defaultDownloadDirectory / 'gt' / 'events'
]

{ #category : #defaults }
GTATool class >> defaultUrl [
	^ 'http://gc.dcc.uchile.cl:8080/gt/events/data'
]

{ #category : #api }
GTATool class >> download [
	"self download"
 	UIManager default informUserDuring: [ :bar |
		bar label: 'Downloading Spotter Event Data...'.
		[ ZnClient new
			url: self defaultUrl;
			signalProgress: true;
			downloadTo: self defaultDownloadFilename ]
		on: HTTPProgress 
		do: [ :progress |
			self haltOnce.
			progress isEmpty ifFalse: [ 
				bar current: progress percentage.
				progress total ifNotNil: [ :aTotalNumber | | length humanReadable unit |
					length := (aTotalNumber decimalDigitLength / 3) truncated.
					humanReadable := (aTotalNumber / (1024 raisedTo: (length min: 3))) rounded.
					length = 0 ifTrue: [ unit := 'bytes' ].
					length = 1 ifTrue: [ unit := 'KB' ].
					length = 2 ifTrue: [ unit := 'MB' ].
					length = 3 ifTrue: [ unit := 'GB' ].
					bar label: 'Downloading ', humanReadable printString, ' ', unit, ' of Spotter Event Data... ' ] ].
			progress resume ] 
	]
]

{ #category : #api }
GTATool class >> ensureDownloadedData [
	self defaultDownloadFilename exists ifFalse: [ self download ]
]

{ #category : #api }
GTATool class >> ensureExctractedData [
	self defaultEventsDirectory exists ifFalse: [ self extract ]
]

{ #category : #api }
GTATool class >> ensureLocalDirectory [
	self 
		ensureDownloadedData;
		ensureExctractedData
]

{ #category : #api }
GTATool class >> extract [
	semaphore := Semaphore new.
	process := ExternalUnixOSProcess 
		forkAndExec: '/usr/bin/tar' 
		arguments: (Array with: 'xzf' with: self defaultDownloadFilename fullName)
		environment: nil 
		descriptors: nil 
		workingDir: self defaultDownloadDirectory fullName.
	process addDependent: self.
	self checkProcess.
	semaphore wait.
	process := nil.
	semaphore := nil.
]

{ #category : #initialization }
GTATool class >> initializeSpotterExtensionTitles [
	spotterExtensionTitles := ((GTSpotter spotterExtendingMethods 
			collect: [ :eachPragma | self titleForSpotterPragma: eachPragma  ])
				removeAllSuchThat: [ :each | each isNil ]) removeDuplicates
]

{ #category : #initialization }
GTATool class >> resetSpotterExtensionTitles [
	spotterExtensionTitles := nil.
]

{ #category : #api }
GTATool class >> spotterExtensionTitles [
	spotterExtensionTitles ifNil: [ self initializeSpotterExtensionTitles ].
	^ spotterExtensionTitles
]

{ #category : #api }
GTATool class >> titleForSpotterPragma: aRGMethodDefinition [ 
	"omit test cases"
	(aRGMethodDefinition selector beginsWith: #mock) ifTrue: [ ^ nil ].

	aRGMethodDefinition compiledMethod ast nodesDo: [ :eachAstNode |
		"moose model"
		(eachAstNode isMessage and: [ eachAstNode selector = #spotter:on:for: ]) ifTrue: [ 
			^ eachAstNode arguments first value ].
		"menu item morph"
		(aRGMethodDefinition methodClass = MenuItemMorph and: [ 
			eachAstNode isMessage and: [ eachAstNode selector = #spotterItemsFor: ] ]) ifTrue: [ 
				^ nil "We obtain the title from other method definition." ].
		"regular method or world menu"
		(eachAstNode isMessage and: [ (eachAstNode selector = #title:) and: [ 
			eachAstNode children size = 2 and: [ | first |
				first := eachAstNode children first.
				first isMessage and: [ (first selector = #listProcessor) or: [ 
						first selector = #spotterItemsFor: ] ] ] ] ]) ifTrue: [ 
							eachAstNode arguments anyOne isLiteralNode 
								ifTrue: [ ^ eachAstNode arguments anyOne value ]
								ifFalse: [ ^ nil "We obtain the title from other method definition." ]
		 ].
	].
	
	self error: 'Should not happen.'.
	^ nil
]

{ #category : #updating }
GTATool class >> update: aParameter [
	aParameter = #runState ifTrue: [ self checkProcess ]
]
