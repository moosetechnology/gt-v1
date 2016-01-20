Class {
	#name : #GTInspectorExamplesManualTest,
	#superclass : #Object,
	#instVars : [
		'allFailures',
		'allClasses',
		'allTestedClasses',
		'allUntestedClasses'
	],
	#category : #'GT-Tests-Inspector'
}

{ #category : #public }
GTInspectorExamplesManualTest class >> reset [
	FileSystem workingDirectory allFiles 
		select: [ :each | each basename beginsWith: 'gtExamples' ]
		thenDo: [ :each | each delete ]
]

{ #category : #private }
GTInspectorExamplesManualTest >> basicRunClasses [
	 self runClasses: allUntestedClasses 
]

{ #category : #private }
GTInspectorExamplesManualTest >> basicRunExample: anExample [
	self checkAllPresentationsOf: anExample onError: [ :aPragma :anException | 
		allFailures add: anExample method.
		self printException: anException forExample: anExample withPragma: aPragma ] 
]

{ #category : #private }
GTInspectorExamplesManualTest >> basicRunFailures [
	" self new runFailures "

	(allFailures := self readFailuresFromFile: (FileSystem workingDirectory / 'gtExamplesAllFailures.txt')) 
		do: [ :each |
			each gtExamples do: [ :example |
				self runExample: example ] ]
		displayingProgress: 'Running ', allFailures size asString, ' failures ...'
]

{ #category : #private }
GTInspectorExamplesManualTest >> checkAllPresentationsOf: exampleToTest onError: aBlock [
	| browser window |
	(Pragma allNamed: #gtInspectorPresentationOrder: from: exampleToTest class to: ProtoObject) do: [ :eachPragma | 
		browser := GLMWrapper new.
		[	browser
				show: [ :composite | 
					(eachPragma selector findTokens: $:) size = 1
						ifTrue: [ exampleToTest perform: eachPragma selector with: composite ].
					(eachPragma selector findTokens: $:) size = 2
						ifTrue: [ exampleToTest perform: eachPragma selector with: composite with: browser ] ].
			window := browser openOn: exampleToTest ] 
				on: Error 
				do: [ :exception |
					window ifNotNil: [ window delete ].
					aBlock value: eachPragma value: exception ].
		window ifNotNil: [ window delete ] ]
]

{ #category : #private }
GTInspectorExamplesManualTest >> examplesForClass: aClass [
	^ aClass gtExamples
]

{ #category : #private }
GTInspectorExamplesManualTest >> filenameFor: anExample [
	^ ((('gtExamplesFailure_', anExample method gtDisplayString		 
			copyReplaceAll: '>' with: '_') 
			copyReplaceAll: ':' with: '.') 
			copyReplaceAll: ' ' with: '') 
			copyReplaceAll: '#' with: ''
]

{ #category : #initialization }
GTInspectorExamplesManualTest >> initialize [
	| fileWithAllClasses fileWithAllTestedClasses |
	super initialize.
		
	" prepare all classes "
	allClasses := {}.
	fileWithAllClasses := FileSystem workingDirectory / 'gtExamplesAllClasses.txt'.
	fileWithAllClasses exists ifTrue: [ 
		allClasses := self readClassesFromFile: fileWithAllClasses ].
	allClasses isEmptyOrNil ifTrue: [
		| streamWithAllClasses |
		allClasses := SystemNavigation default allClassesAndTraits sort: [ :a :b | a name <= b name ].
		streamWithAllClasses := fileWithAllClasses writeStream.
		allClasses do: [ :each | streamWithAllClasses nextPutAll: each name; cr. ].
		streamWithAllClasses flush; close. ].

	" prepare tested classes "
	allTestedClasses := {}.
	fileWithAllTestedClasses := FileSystem workingDirectory / 'gtExamplesAllTestedClasses.txt'.
	fileWithAllTestedClasses exists ifTrue: [ 
		allTestedClasses := self readClassesFromFile: fileWithAllTestedClasses ].
	
	" prepare untested classes "
	allUntestedClasses := (allClasses difference: allTestedClasses) sort: [ :a :b | a name <= b name ].
	
	" prepare failures "
	allFailures := self readFailuresFromFile: (FileSystem workingDirectory / 'gtExampleAllFailures.txt').
]

{ #category : #private }
GTInspectorExamplesManualTest >> printException: anException forExample: anExample withPragma: aPragma [
	(FileSystem workingDirectory / 'gtExamplesAllFailures.txt') writeStream 
		setToEnd; cr;
		nextPutAll: anExample method gtDisplayString; cr;
		flush;
		close.
	(FileSystem workingDirectory / (self filenameFor: anExample)) writeStream 
		truncate;
		nextPutAll: anExample gtDisplayString; cr;
		nextPutAll: aPragma gtDisplayString; cr;
		nextPutAll: anException asString; cr;
		nextPutAll: '--------------------------------------------------------------------------------'; cr;
		nextPutAll: (String streamContents: [ :stream | 
							anException signalerContext ifNotNil: [ :context | 
								context debugStackOn: stream ] ] );
		flush;
		close
]

{ #category : #private }
GTInspectorExamplesManualTest >> readClassesFromFile: aFile [
	aFile exists ifFalse: [ ^ OrderedCollection new ].
	^ ((aFile readStream contents splitOn: String cr) 
		collect: [ :each | [ Smalltalk classNamed: each trimBoth ] on: Error do: [ nil ] ]) 
		reject: [ :each | each isNil ]
]

{ #category : #private }
GTInspectorExamplesManualTest >> readFailuresFromFile: aFile [
	aFile exists ifFalse: [ ^ OrderedCollection new ].
	^ (((aFile readStream contents splitOn: String cr)
		collect: [ :each | [ Compiler evaluate: each trimBoth ] on: Error do: [ nil ] ])
		reject: [ :each | each isNil ]) asSet asOrderedCollection
]

{ #category : #public }
GTInspectorExamplesManualTest >> run [
	" self new run "
	
	self run: [ self basicRunClasses ]
]

{ #category : #private }
GTInspectorExamplesManualTest >> run: aBlock [
	
	[ GTExampleOrganizer instance stop. aBlock value ]
		ensure: [ GTExampleOrganizer instance start ].
	
	self verify
]

{ #category : #private }
GTInspectorExamplesManualTest >> runClasses: aCollectionOfClasses [
	aCollectionOfClasses
		do:
			[ :class | 
			(self examplesForClass: class) do: [ :example | self runExample: example ] displayingProgress: class name.
			(FileSystem workingDirectory / 'gtExamplesAllTestedClasses.txt') writeStream
				setToEnd;
				cr;
				nextPutAll: class name;
				flush;
				close ]
		displayingProgress: 'Running examples of ' , aCollectionOfClasses size asString , ' classes ...'
]

{ #category : #private }
GTInspectorExamplesManualTest >> runExample: anExample [
	[ self basicRunExample: anExample ]
		on: Error
		do: [ :exception | 
			allFailures add: anExample method.
			self printException: exception forExample: anExample withPragma: nil ] 
]

{ #category : #public }
GTInspectorExamplesManualTest >> runFailures [
	" self new runFailures "
	
	self run: [ self basicRunFailures ]
]

{ #category : #private }
GTInspectorExamplesManualTest >> verify [
	self assert: allFailures isEmptyOrNil description: (String streamContents: [ :stream |
		allFailures do: [ :each | 
			stream nextPutAll: each gtDisplayString; cr ] ] )
]
