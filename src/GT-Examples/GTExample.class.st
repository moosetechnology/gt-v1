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
		'methodClass',
		'selector',
		'label',
		'description',
		'form',
		'exceptions',
		'subjects',
		'children',
		'properties',
		'after',
		'failures'
	],
	#category : #'GT-Examples-Core'
}

{ #category : #examples }
GTExample class >> gtExampleFromPragma [
	<gtExample>
	^ GTExampleFinderOLD new newExampleFromPragma: (self class>>#gtExampleFromPragma) pragmas first
]

{ #category : #testing }
GTExample >> = anExample [
	^ self class = anExample class 
		and: [ self methodClass = anExample methodClass 
			and: [ self selector = anExample selector ] ]
]

{ #category : #accessing }
GTExample >> after [
	^ after
]

{ #category : #'pragma-selectors' }
GTExample >> after: aSelector [
	<gtExamplePragma>
	<description: 'A method, provided by the given selector, to be performed after this example has run ~ similar but not identical to teardown of sunit'>
	
	after := self methodForSelector: aSelector
]

{ #category : #'accessing-dynamic' }
GTExample >> afterArguments [
	self after ifNil: [ ^ #() ].
	^ self after arguments
]

{ #category : #'pragma-selectors' }
GTExample >> afterClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'A method (implemented by a gtExampleProvider) to be performed after this example has run ~ similar but not identical to teardown of sunit'>
	
	after := self methodForClassNamed: aClassOrClassName selector: aSelector
]

{ #category : #'accessing-dynamic' }
GTExample >> allDependencies [
	| examples |
	examples := Set new.
	(self traverser
		action: [ :example | examples add: example ];
		yourself) value.
	^ examples
]

{ #category : #'accessing-dynamic' }
GTExample >> allDependents [
	| examples |
	examples := Set new.
	(self traverser reversed
		action: [ :example | examples add: example ];
		yourself) value.
	^ examples
]

{ #category : #'accessing-dynamic' }
GTExample >> arguments [
	^ children asArray
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

{ #category : #actions }
GTExample >> debug [
	^ self debugger result
]

{ #category : #'accessing-dynamic' }
GTExample >> debugger [
	^ GTExampleDebugger new 
		example: self;
		yourself
]

{ #category : #'accessing-dynamic' }
GTExample >> dependencies [
	^ self arguments collect: [ :each | each gtExample ]
]

{ #category : #'accessing-dynamic' }
GTExample >> dependenciesOrArguments [
	^ self arguments collect: [ :each | each gtExample ifNil: [ each ] ]
]

{ #category : #'pragma-selectors' }
GTExample >> depends: aSelector [
	<gtExamplePragma>
	<description: 'This example depends on the example declared by the given selector. Any dependency will be performed before this example is performed. Order of declaration is important'>
	
	children add: (self methodForSelector: aSelector)
]

{ #category : #'pragma-selectors' }
GTExample >> dependsAll: aString [
	<gtExamplePragma>
	<description: 'This example depends on all given selectors found in the given string. Any dependency will be performed before this example is performed. Order of declaration is important'>
	
	self substrings: aString do: [ :each | 
		self depends: aString ]
]

{ #category : #'pragma-selectors' }
GTExample >> dependsClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'This example depends on the example declared by the given class and selector. Any dependency will be performed before this example is performed. Order of declaration is important'>
	
	children add: (self methodForClassNamed: aClassOrClassName selector: aSelector)
]

{ #category : #accessing }
GTExample >> description [
	^ description
]

{ #category : #'pragma-selectors' }
GTExample >> description: anObject [
	<gtExamplePragma>
	<description: 'A full description of this example'>
	
	description := anObject
]

{ #category : #'accessing-dynamic' }
GTExample >> directDependents [
	<todo: 'better name -> #myDependents and #dependents is taken - wtf!'>
	^ (GTExampleOrganizer instance examplesSelect: [ :each | each hasDependency: self ]) asSet
]

{ #category : #testing }
GTExample >> equalsExample: anExampleOrExampleProxy [
	^ anExampleOrExampleProxy isGTExample
		ifTrue: [ self class = anExampleOrExampleProxy class and: [ self = anExampleOrExampleProxy ] ]
		ifFalse: [ anExampleOrExampleProxy equalsExample: self ]
]

{ #category : #'accessing-dynamic' }
GTExample >> evaluator [
	^ GTExampleEvaluator new 
		example: self;
		yourself
]

{ #category : #accessing }
GTExample >> exceptions [
	^ exceptions
]

{ #category : #testing }
GTExample >> exists [
	^ self methodClass includesSelector: self selector
]

{ #category : #accessing }
GTExample >> failures [
	^ failures
]

{ #category : #ui }
GTExample >> gtDebuggerSourceIn: composite [
	<gtDebuggerPresentationOrder: 1>
	self hasMethod ifFalse: [ ^ self ].
	^ (self method gtInspectorSourceIn: composite)
		title: 'Method'
]

{ #category : #ui }
GTExample >> gtDisplayOn: aStream [
	self printOn: aStream.
	aStream nextPutAll: ' ('.
	self gtDisplaySummaryOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #ui }
GTExample >> gtDisplaySummaryOn: aStream. [
	self label isEmptyOrNil 
		ifFalse: [ ^ aStream nextPutAll: self label ].
	self description isEmptyOrNil 
		ifFalse: [ ^ aStream nextPutAll: self description ].
	aStream 
		print: self methodClass; 
		nextPutAll: '>>'; 
		print: self selector.
]

{ #category : #'pragma-selectors' }
GTExample >> gtExample [
	<gtExamplePragma>
	<description: 'This method is turned into a gtExample if provided'>
	
	^ self
]

{ #category : #'pragma-selectors' }
GTExample >> gtExample: anObject [
	<toBeDeprecated: 'Please define your example-label (or description) using the pragma #label: or #description:'>
	self label: anObject.
	self gtExample
]

{ #category : #'accessing-dynamic' }
GTExample >> gtExamplesContained [
	^ { self }
]

{ #category : #'accessing-dynamic' }
GTExample >> gtExamplesFactory [
	^ self method gtExamplesFactory
]

{ #category : #ui }
GTExample >> gtInspectorActionEvaluateResultAndGo [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :p | p selection: self returnValue ];
		icon: (Smalltalk ui icons iconNamed: #glamorousRight);
		title: 'Evaluate result and go'
]

{ #category : #ui }
GTExample >> gtInspectorDependenciesIn: composite [
	<gtInspectorPresentationOrder: 2>
	self hasDependencies ifFalse: [ ^ self ].
	^ (self dependenciesOrArguments gtInspectorItemsIn: composite)
			title: 'Dependencies'
]

{ #category : #ui }
GTExample >> gtInspectorDependentsIn: composite [
	<gtInspectorPresentationOrder: 3>
	self hasDependents ifFalse: [ ^ self ].
	^ (self directDependents gtInspectorItemsIn: composite)
			title: 'Dependents'
]

{ #category : #ui }
GTExample >> gtInspectorMethodIn: composite [
	<gtInspectorPresentationOrder: 0>
	self hasMethod ifFalse: [ ^ self ].
	^ (self method gtInspectorSourceIn: composite)
		title: 'Method'
]

{ #category : #ui }
GTExample >> gtInspectorRoassalIn: composite [
	<gtInspectorPresentationOrder: 1>
	self hasRelationships ifFalse: [ ^ self ].
	^ self painter gtInspectorRoassalIn: composite
]

{ #category : #ui }
GTExample >> gtSpotterDependenciesFor: aStep [
	<spotterOrder: 100>
	self hasDependencies ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'Example Dependencies';
		allCandidates: [ self dependenciesOrArguments ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #ui }
GTExample >> gtSpotterDependentsFor: aStep [
	<spotterOrder: 101>
	self hasDependents ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'Example Dependents';
		allCandidates: [ self directDependents ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #ui }
GTExample >> gtSpotterMethodFor: aStep [
	<spotterOrder: 103>
	self hasMethod ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'Method';
		items: [ Array with: self method ];
		itemName: [ :aSource | aSource gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #ui }
GTExample >> gtSpotterPreviewIn: aComposite [
	<spotterPreview: 1>
	self hasMethod ifFalse: [ ^ self ].
	aComposite pharoMethod
		title: [ self gtDisplayString ]; 
		display: [ :entity | entity method sourceCode ];
		smalltalkClass: [ self method methodClass ];
		entity: self
]

{ #category : #ui }
GTExample >> gtSpotterSubjectsFor: aStep [
	<spotterOrder: 102>
	self hasSubjects ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'Example Subjects';
		allCandidates: [ self subjects ];
		itemName: [ :subject | subject gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #testing }
GTExample >> hasAfter [
	^ after notNil
]

{ #category : #testing }
GTExample >> hasAfterArguments [
	^ self hasAfter
		and: [ self after hasArguments ]
]

{ #category : #testing }
GTExample >> hasArguments [
	^ self arguments notEmpty
]

{ #category : #testing }
GTExample >> hasDependencies [
	^ self arguments notEmpty
]

{ #category : #testing }
GTExample >> hasDependency: aGTExample [
	^ self arguments anySatisfy: [ :each | each matchesExample: aGTExample ]
]

{ #category : #testing }
GTExample >> hasDependent: anExample [
	^ self directDependents anySatisfy: [ :each | each matchesExample: anExample ]
]

{ #category : #testing }
GTExample >> hasDependents [
	^ self directDependents notEmpty
]

{ #category : #testing }
GTExample >> hasFailures [
	^ failures notEmpty
]

{ #category : #testing }
GTExample >> hasMethod [
	^ self exists
]

{ #category : #testing }
GTExample >> hasRelationships [
	^ self hasDependents
		or: [ self hasDependencies ]
]

{ #category : #testing }
GTExample >> hasSubject: aSubject [
	^ self classNamed: aSubject 
		do: [ :class | self subjects includes: class ] 
		ifNone: [ self subjects includes: aSubject ]
]

{ #category : #testing }
GTExample >> hasSubjects [
	^ self subjects notEmpty
]

{ #category : #testing }
GTExample >> hasValidAfterArguments [
	^ self hasAfterArguments not
		or: [ self after hasValidArguments ]
]

{ #category : #testing }
GTExample >> hasValidArguments [
	^ self arguments size = self method numArgs
]

{ #category : #testing }
GTExample >> hasValidDependencies [
	^ self hasDependencies
		and: [ self hasValidArguments 
			and: [ self dependencies allSatisfy: [ :each | 
					each notNil and: [ each exists ] ] ] ]
]

{ #category : #testing }
GTExample >> hash [
	^ (self class hash 
		bitXor: self methodClass hash) 
			bitXor: self selector hash
]

{ #category : #accessing }
GTExample >> icon [
	^ form
]

{ #category : #'pragma-selectors' }
GTExample >> icon: aSelector [
	<gtExamplePragma>
	<description: 'This is a shortcut for: #iconThemeSelector:'>
	
	self iconThemeSelector: aSelector
]

{ #category : #'pragma-selectors' }
GTExample >> iconBase64: aString [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The string must represent a base64 string'>
	
	form := Form fromBinaryStream: (Base64MimeConverter mimeDecodeToBytes: aString readStream)
]

{ #category : #'pragma-selectors' }
GTExample >> iconBytes: aByteArray [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The icon form is described by the given byte-array'>
	
	form := (Form
		extent: 16@16
		depth: 32
		fromArray: aByteArray 
		offset: 0@0)
]

{ #category : #'pragma-selectors' }
GTExample >> iconClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The method described by the given class and selector must return a form-icon'>
	
	self classNamed: aClassOrClassName do: [ :class | 
		form := class perform: aSelector ]
]

{ #category : #'pragma-selectors' }
GTExample >> iconSelector: aSelector [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The selector must return an icon form'>
	
	form := self provider perform: aSelector
]

{ #category : #'pragma-selectors' }
GTExample >> iconSelectorBase64: aSelector [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The selector must return a base64 string'>
	
	self iconBase64: (self provider perform: aSelector)
]

{ #category : #'pragma-selectors' }
GTExample >> iconThemeSelector: aSelector [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The selector must be implemented by the currently active theme'>
	
	form := Smalltalk ui icons perform: aSelector
]

{ #category : #testing }
GTExample >> ignoreTest [
	^ self propertyAt: #noTest ifAbsent: [ false ]
]

{ #category : #testing }
GTExample >> ignoreTestReport [
	^ self propertyAt: #noTestReport ifAbsent: [ false ]
]

{ #category : #initializing }
GTExample >> initialize [
	super initialize.
	
	parents := Set new.
	children := OrderedCollection new.
	subjects := Set new.
	failures := Set new.
	exceptions := ExceptionSet new.	
	properties := IdentityDictionary new.
]

{ #category : #testing }
GTExample >> isGTExample [
	^ true
]

{ #category : #testing }
GTExample >> isValid [
	^ self failures isEmpty
]

{ #category : #accessing }
GTExample >> label [
	^ label
]

{ #category : #'pragma-selectors' }
GTExample >> label: anObject [
	<gtExamplePragma>
	<description: 'A short identifier of the name of this example'>
	
	label := anObject
]

{ #category : #testing }
GTExample >> matchesMethod: aCompiledMethod [
	^ aCompiledMethod class = CompiledMethod
		and: [ self methodClass = aCompiledMethod methodClass
			and: [ self selector = aCompiledMethod selector ] ]
]

{ #category : #'accessing-dynamic' }
GTExample >> method [
	^ self methodClass >> self selector
]

{ #category : #accessing }
GTExample >> methodClass [
	^ methodClass
]

{ #category : #accessing }
GTExample >> methodClass: aClass [
	methodClass := aClass
]

{ #category : #private }
GTExample >> methodForClass: aClass named: aClassName selector: aSelector [
	^ GTExampleMethod new
		methodClass: aClass;
		methodClassName: aClassName;
		selector: aSelector asSymbol;
		yourself
]

{ #category : #private }
GTExample >> methodForClass: aClass selector: aSelector [
	^ self methodForClass: aClass named: aClass name selector: aSelector
]

{ #category : #private }
GTExample >> methodForClassNamed: aClassOrClassName selector: aSelector [
	^ self classNamed: aClassOrClassName 
		do: [ :class | self methodForClass: class named: class name selector: aSelector ] 
		ifNone: [ self methodForClass: nil named: aClassOrClassName selector: aSelector ]
]

{ #category : #private }
GTExample >> methodForSelector: aSelector [
	^ self methodForClass: self methodClass selector: aSelector
]

{ #category : #'accessing-dynamic' }
GTExample >> methodReference [
	^ self method asRingDefinition
]

{ #category : #'pragma-selectors' }
GTExample >> noTest [
	<gtExamplePragma>
	<description: 'Do not run this example while running SUnit tests'>
	
	self propertyAt: #noTest put: true
]

{ #category : #'pragma-selectors' }
GTExample >> noTestReport [
	<gtExamplePragma>
	<description: 'Do not run this example while running HDTestReport (not yet implemented)'>
	
	self propertyAt: #noTestReport put: true
]

{ #category : #ui }
GTExample >> painter [
	^ GTExamplePainter new 
		example: self;
		yourself
]

{ #category : #accessing }
GTExample >> propertyAt: aKey [
	^ (properties ifNil: [ KeyNotFound signalFor: aKey ])
		at: aKey
]

{ #category : #accessing }
GTExample >> propertyAt: aKey ifAbsent: aBlock [
	^ (properties ifNil: [ ^ aBlock value ])
		at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
GTExample >> propertyAt: aKey ifAbsentPut: aBlock [
	^ (properties ifNil: [ properties := IdentityDictionary new ])
		at: aKey ifAbsentPut: aBlock
]

{ #category : #accessing }
GTExample >> propertyAt: aKey put: aValue [
	^ (properties ifNil: [ properties := IdentityDictionary new ])
		at: aKey put: aValue
]

{ #category : #'accessing-dynamic' }
GTExample >> provider [ 
	^ self methodClass isMeta
		ifTrue: [ self methodClass theNonMetaClass ]
		ifFalse: [ self methodClass theNonMetaClass new ]
]

{ #category : #'pragma-selectors' }
GTExample >> raises: aClassOrClassName [
	<gtExamplePragma>
	<description: 'This example is expected to raise the given exception. The example will fail if the exception is not raised.'>
	
	self classNamed: aClassOrClassName do: [ :class | 
		self exceptions add: class ]
]

{ #category : #'pragma-selectors' }
GTExample >> raisesAny: aString [
	<gtExamplePragma>
	<description: 'This example is expected to raise any of the given exceptions. The example will fail if none of the exceptions is raised.'>
	
	self substrings: aString do: [ :each | 
		self raises: each ]
]

{ #category : #initializing }
GTExample >> reinitialize [
	| method |
	(method := self method) gtExamplesFactory 
		initializeFromMethod: method forExample: self
]

{ #category : #'accessing-dynamic' }
GTExample >> returnValue [
	^ self result returnValue
]

{ #category : #actions }
GTExample >> run [
	^ self evaluator result 
]

{ #category : #accessing }
GTExample >> selector [
	^ selector
]

{ #category : #accessing }
GTExample >> selector: aSelector [
	selector := aSelector
]

{ #category : #'accessing-dynamic' }
GTExample >> signalableExceptions [
	^ self exceptions copyWithAll: { Halt. Error. Exit. UnhandledError. TestFailure. Deprecation. }
]

{ #category : #'accessing-dynamic' }
GTExample >> sourceCode [
	^ self method sourceCode
]

{ #category : #ui }
GTExample >> spotterPreviewIn: aComposite inContext: aSpotter [
	^ self gtSpotterPreviewIn: aComposite
]

{ #category : #'pragma-selectors' }
GTExample >> subject: aClassOrClassName [
	<gtExamplePragma>
	
	self classNamed: aClassOrClassName do: [ :class | 
		self subjects add: class asGTExampleSubject ]
]

{ #category : #accessing }
GTExample >> subjects [
	^ subjects
]

{ #category : #'pragma-selectors' }
GTExample >> subjectsAll: aString [
	<gtExamplePragma>
	
	self substrings: aString do: [ :each | 
		self subject: each ]
]

{ #category : #private }
GTExample >> substrings: aString do: aBlock [
	(aString substrings: ' .,;') do: [ :each | 
		aBlock value: each trimBoth ]
]

{ #category : #'accessing-dynamic' }
GTExample >> traverser [
	^ GTExampleTraverser new 
		example: self;
		yourself
]
