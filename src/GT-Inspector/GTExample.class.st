"
I represent the concept of an example.

I am constructed out of a method that returns an object. I hold the meta-information about that method and I know how to construct the concrete resulting object that is returned by the method. 

I can depend on other examples, and other examples can depend on me. When I depend on another example, the code that produces me uses the result of the other example to construct me.

The class for which I represent the example is called my subject.

The class that offers the method out of which I am constructed is the provider.

I also know how to handle possible exceptions, which makes me a great candidate for encoding assumptions that are otherwise expressed as classic tests.
"
Class {
	#name : #GTExample,
	#superclass : #Object,
	#instVars : [
		'source',
		'provider',
		'finder',
		'pragma',
		'label',
		'description',
		'form',
		'exceptions',
		'subjects',
		'parents',
		'children',
		'result'
	],
	#category : #'GT-Inspector-Examples-Core'
}

{ #category : #testing }
GTExample >> = anExample [
	^ self class = anExample class 
		and: [ self pragma = anExample pragma 
			and: [ self method = anExample method
				and: [ self method selector = anExample method selector
					and: [ self method methodClass = anExample method methodClass ] ] ] ]
]

{ #category : #public }
GTExample >> allDependencies [
	| examples |
	examples := Set new.
	(self traverser
		action: [ :example | examples add: example ];
		yourself) value.
	^ examples
]

{ #category : #public }
GTExample >> allDependents [
	| examples |
	examples := Set new.
	(self traverser reversed
		action: [ :example | examples add: example ];
		yourself) value.
	^ examples
]

{ #category : #public }
GTExample >> arguments [
	^ children asArray
]

{ #category : #private }
GTExample >> children [
	^ children
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> childrenExamples [
	<todo: 'deprecated: #childrenExamples'>
	^ self dependencies
]

{ #category : #private }
GTExample >> classNamed: aClassOrClassName [
	^ aClassOrClassName isClass 
		ifTrue: [ aClassOrClassName ]
		ifFalse: [ Smalltalk classNamed: aClassOrClassName asString ]
]

{ #category : #private }
GTExample >> classNamed: aClassName do: aBlock [
	^ self classNamed: aClassName do: aBlock ifNone: [ 
		(GTExampleDeclaredClassMissing new
			example: self;
			classNamed: aClassName;
			yourself) signal ]
]

{ #category : #private }
GTExample >> classNamed: aClassName do: aBlock1 ifNone: aBlock2 [
	^ (self classNamed: aClassName)
		ifNotNil: aBlock1
		ifNil: aBlock2
]

{ #category : #public }
GTExample >> debug [
	^ self debugger result
]

{ #category : #public }
GTExample >> debugger [
	^ GTExampleDebugger new 
		example: self;
		yourself
]

{ #category : #public }
GTExample >> dependencies [
	^ self arguments collect: [ :each | each example ]
]

{ #category : #private }
GTExample >> dependenciesOrErrors [
	^ self arguments collect: [ :each | 
		[ each example ] 
			on: Error 
			do: [ :exception | exception ] ]
]

{ #category : #public }
GTExample >> dependents [
	^ self parents asArray collect: [ :each | each owner ]
]

{ #category : #'pragma-selectors' }
GTExample >> depends: aSelector [
	children add: (GTExampleProxy new
		owner: self;
		provider: self provider;
		selector: aSelector asSymbol;
		yourself)
]

{ #category : #'pragma-selectors' }
GTExample >> dependsAll: aString [
	self substrings: aString do: [ :each | 
		self depends: aString ]
]

{ #category : #'pragma-selectors' }
GTExample >> dependsClass: aClassOrClassName selector: aSelector [
	self classNamed: aClassOrClassName do: [ :class | 
		children add: (GTExampleProxy new
			owner: self;
			provider: class gtExamplesProvider; " we have to resolve the kind of example again - it could be implemented in #class or in the provider of #class ! "
			selector: aSelector asSymbol;
			yourself) ]
]

{ #category : #accessing }
GTExample >> description [
	^ description
]

{ #category : #'pragma-selectors' }
GTExample >> description: anObject [
	description := anObject
]

{ #category : #private }
GTExample >> detachFromSystem [
	(self traverser reversed
		action: [ :example | example detachResultFromSystem ];
		onRecursionError: [ :aProcessor :anExample | " ignore and continue " ];
		yourself) value.
	children do: [ :proxy | proxy detachFromSystem ].
	parents do: [ :proxy | proxy detachFromSystem ].
	children := OrderedCollection new.
	parents := Set new.
]

{ #category : #private }
GTExample >> detachResultFromSystem [
	result ifNil: [ ^ self ].
	result detachFromSystem.
	result := nil.
]

{ #category : #testing }
GTExample >> equalsExample: anExampleOrExampleProxy [
	^ anExampleOrExampleProxy isGTExample
		ifTrue: [ self class = anExampleOrExampleProxy class and: [ self = anExampleOrExampleProxy ] ]
		ifFalse: [ anExampleOrExampleProxy equalsExample: self ]
]

{ #category : #public }
GTExample >> evaluator [
	^ GTExampleEvaluator new 
		example: self;
		yourself
]

{ #category : #public }
GTExample >> example [
	^ self
]

{ #category : #accessing }
GTExample >> exceptions [
	^ exceptions
]

{ #category : #testing }
GTExample >> exists [
	^ self method methodClass includesSelector: self method selector
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> extractionStrategy [
	<todo: 'deprecated: #extractionStrategy'>
	self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> extractionStrategy: anObject [
	<todo: 'deprecated: #extractionStrategy:'>
	self shouldNotImplement
]

{ #category : #accessing }
GTExample >> finder [ 
	^ finder
]

{ #category : #ui }
GTExample >> gtDebuggerSourceIn: composite [
	<gtDebuggerPresentationOrder: 1>
	self method gtInspectorSourceIn: composite
]

{ #category : #ui }
GTExample >> gtDisplayOn: aStream [
	self printOn: aStream.
	aStream nextPutAll: ' ('.
	self gtDisplaySummaryOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> gtDisplaySourceIn: composite [
	<todo: 'deprecated: #gtDisplaySourceIn:'>
	^ self gtInspectorSourceIn: composite
]

{ #category : #ui }
GTExample >> gtDisplaySummaryOn: aStream. [
	self label isEmptyOrNil 
		ifFalse: [ ^ aStream nextPutAll: self label ].
	self description isEmptyOrNil 
		ifFalse: [ ^ aStream nextPutAll: self description ].
	aStream nextPutAll: self method name
]

{ #category : #'pragma-selectors' }
GTExample >> gtExample [
	^ self
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> gtExample: anObject [
	<todo: 'deprecated: #gtExample:'>
	self label: anObject.
	^ self gtExample
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> gtExampleFrom: aSelector [
	<todo: 'deprecated: #gtExampleFrom:'>
	^ self depends: aSelector
]

{ #category : #ui }
GTExample >> gtInspectorActionEvaluateResultAndGo [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :p | p selection: self result ];
		icon: Smalltalk ui icons glamorousRight;
		title: 'Evaluate result and go'
]

{ #category : #ui }
GTExample >> gtInspectorDependenciesIn: composite [
	<gtInspectorPresentationOrder: 2>
	^ ((self dependenciesOrErrors ifEmpty: [ ^ self ]) 
			gtInspectorItemsIn: composite)
				title: 'Dependencies'
]

{ #category : #ui }
GTExample >> gtInspectorDependentsIn: composite [
	<gtInspectorPresentationOrder: 3>
	^ ((self dependents ifEmpty: [ ^ self ]) 
			gtInspectorItemsIn: composite)
				title: 'Dependents'
]

{ #category : #ui }
GTExample >> gtInspectorRoassalIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ self painter gtInspectorRoassalIn: composite
]

{ #category : #ui }
GTExample >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ (self method gtInspectorSourceIn: composite)
		title: 'Source'
]

{ #category : #ui }
GTExample >> gtSpotterDependenciesFor: aStep [
	<spotterOrder: 100>
	aStep listProcessor
		title: 'Example Dependencies';
		allCandidates: [ self arguments ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #ui }
GTExample >> gtSpotterDependentsFor: aStep [
	<spotterOrder: 101>
	aStep listProcessor
		title: 'Example Dependents';
		allCandidates: [ self dependents ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #ui }
GTExample >> gtSpotterPreviewIn: aComposite [
	<spotterPreview: 1>
	^ aComposite pharoMethod
		title: [ self gtDisplayString ]; 
		display: [ :entity | entity method sourceCode ];
		smalltalkClass: [ self method methodClass ];
		entity: self
]

{ #category : #testing }
GTExample >> hasDependency: anExample [
	(self traverser
		action: [ :example | (example equalsExample: anExample) ifTrue: [ ^ true ] ];
		yourself) value.
	^ false
]

{ #category : #testing }
GTExample >> hasDependent: anExample [
	(self traverser reversed
		action: [ :example | (example equalsExample: anExample) ifTrue: [ ^ true ] ];
		yourself) value.
	^ false
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> hasParentExample [
	<todo: 'deprecated: #hasParentExample'>
	^ self dependents notEmpty
]

{ #category : #testing }
GTExample >> hasSubject: aSubject [
	^ self classNamed: aSubject do: [ :class | self subjects includes: class ] ifNone: [ false ]
]

{ #category : #testing }
GTExample >> hasValidArguments [
	^ self arguments size = self method numArgs
]

{ #category : #testing }
GTExample >> hasValidDependencies [
	[ self dependencies ]
		on: Error
		do: [ ^ false ].
	^ true
]

{ #category : #public }
GTExample >> hash [
	^ (((self class hash 
		bitXor: self pragma hash) 
			bitXor: self method hash)
				bitXor: self method selector hash)
					bitXor: self method methodClass hash
]

{ #category : #accessing }
GTExample >> icon [
	^ form
]

{ #category : #'pragma-selectors' }
GTExample >> icon: aSelector [
	self iconThemeSelector: aSelector
]

{ #category : #'pragma-selectors' }
GTExample >> iconBase64: aString [
	form := (Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: aString readStream))
]

{ #category : #'pragma-selectors' }
GTExample >> iconBytes: aByteArray [
	form := (Form
		extent: 16@16
		depth: 32
		fromArray: aByteArray 
		offset: 0@0)
]

{ #category : #'pragma-selectors' }
GTExample >> iconClass: aClassOrClassName selector: aSelector [
	self classNamed: aClassOrClassName do: [ :class | 
		form := (class perform: aSelector) ]
]

{ #category : #'pragma-selectors' }
GTExample >> iconSelector: aSelector [
	form := (self provider perform: aSelector)
]

{ #category : #'pragma-selectors' }
GTExample >> iconThemeSelector: aSelector [
	form := (Smalltalk ui icons perform: aSelector)
]

{ #category : #initializing }
GTExample >> initializeFromFinder: aFinder withPragma: aPragma [
	finder := aFinder.
	pragma := aPragma.
	source := aFinder source.
	provider := aFinder provider.
	subjects := aFinder subjects.
	exceptions := ExceptionSet new.
	children := OrderedCollection new.
	parents := Set new.
	
	aPragma method pragmas do: [ :p |
		(self class canPerform: p keyword) 
			ifTrue: [ self perform: p keyword withArguments: p arguments ] ].
]

{ #category : #testing }
GTExample >> isGTExample [
	^ true
]

{ #category : #testing }
GTExample >> isValid [
	^ self traverser canProcess
]

{ #category : #accessing }
GTExample >> label [
	^ label
]

{ #category : #'pragma-selectors' }
GTExample >> label: anObject [
	label := anObject
]

{ #category : #testing }
GTExample >> matchesMethod: aCompiledMethod [
	^ aCompiledMethod class = CompiledMethod
		and: [ self method methodClass = aCompiledMethod methodClass
			and: [ self method selector = aCompiledMethod selector ] ]
]

{ #category : #public }
GTExample >> method [
	^ self pragma method
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> methodReference [
	<todo: 'deprecated: #methodReference'>
	^ self method asRingDefinition
]

{ #category : #public }
GTExample >> painter [
	^ GTExamplePainter new 
		example: self;
		yourself
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> parentExample: anObject [
	<todo: 'deprecated: #parentExample:'>
	^ self shouldNotImplement
]

{ #category : #private }
GTExample >> parents [
	^ parents
]

{ #category : #accessing }
GTExample >> pragma [
	^ pragma
]

{ #category : #accessing }
GTExample >> provider [
	^ provider
]

{ #category : #'pragma-selectors' }
GTExample >> raises: aClassOrClassName [
	self classNamed: aClassOrClassName do: [ :class | 
		self exceptions add: class ]
]

{ #category : #'pragma-selectors' }
GTExample >> raisesAny: aString [
	self substrings: aString do: [ :each | 
		self raises: each ]
]

{ #category : #accessing }
GTExample >> result [
	^ result ifNil: [ self run ]
]

{ #category : #private }
GTExample >> result: aResult [
	result := aResult
]

{ #category : #public }
GTExample >> returnValue [
	^ self result returnValue
]

{ #category : #public }
GTExample >> run [
	^ result := self evaluator result 
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> selector [
	<todo: 'deprecated: #selector'>
	^ self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> selector: aSelector [
	<todo: 'deprecated: #selector:'>
	^ self shouldNotImplement
]

{ #category : #accessing }
GTExample >> source [
	^ source
]

{ #category : #public }
GTExample >> sourceCode [
	^ self method sourceCode
]

{ #category : #ui }
GTExample >> spotterPreviewIn: aComposite inContext: aSpotter [
	<todo: 'deprecated: #spotterPreviewIn:inContext:'>
	^ self gtSpotterPreviewIn: aComposite
	"
	^ self result spotterPreviewIn: aComposite inContext: aSpotter
	"
]

{ #category : #'pragma-selectors' }
GTExample >> subject: aClassOrClassName [
	self classNamed: aClassOrClassName do: [ :class | 
		self subjects add: class ]
]

{ #category : #accessing }
GTExample >> subjects [
	^ subjects
]

{ #category : #'pragma-selectors' }
GTExample >> subjectsAll: aString [
	self substrings: aString do: [ :each | 
		self subject: each ]
]

{ #category : #private }
GTExample >> substrings: aString do: aBlock [
	(aString substrings: ' .,;') do: [ :each | 
		aBlock value: each trimBoth ]
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> title [
	<todo: 'deprecated: #title'>
	^ self gtDisplayString
	"
	^ title 
		ifNil: [ self result ]
		ifNotNil: [ title ]
	"
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> title: aString [
	<todo: 'deprecated: #title:'>
	self label: aString
	"
	title: aString
		title := aString
	"
]

{ #category : #public }
GTExample >> traverser [
	^ GTExampleTraverser new 
		example: self;
		yourself
]
