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
		'parents',
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

{ #category : #DEPRECATED }
GTExample >> afterFinish [
	^ afterFinish
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

{ #category : #DEPRECATED }
GTExample >> children [
	^ children
]

{ #category : #DEPRECATED }
GTExample >> childrenExamples [
	self deprecated: 'Please use #dependencies instead'.
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

{ #category : #public }
GTExample >> dependencies [
	^ self arguments collect: [ :each | each example ]
]

{ #category : #DEPRECATED }
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

{ #category : #DEPRECATED }
GTExample >> detachFromSystem [
	self detachResultFromSystem.
	(self traverser reversed
		action: [ :example | example detachResultFromSystem ];
		onRecursionError: [ :aProcessor :anExample | " ignore and continue " ];
		yourself) value.
	children do: [ :proxy | proxy detachFromSystem ].
	parents do: [ :proxy | proxy detachFromSystem ].
	children := OrderedCollection new.
	parents := Set new.
]

{ #category : #DEPRECATED }
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

{ #category : #'accessing-dynamic' }
GTExample >> evaluator [
	^ GTExampleEvaluator new 
		example: self;
		yourself
]

{ #category : #'accessing-dynamic' }
GTExample >> example [
	^ self
]

{ #category : #accessing }
GTExample >> exceptions [
	^ exceptions
]

{ #category : #testing }
GTExample >> exists [
	^ self methodClass includesSelector: self selector
]

{ #category : #DEPRECATED }
GTExample >> extractionStrategy [
	self deprecated: 'Please define your examples using pragmas'.
	^ self shouldNotImplement
]

{ #category : #DEPRECATED }
GTExample >> extractionStrategy: anObject [
	self deprecated: 'Please define your examples using pragmas'.
	self shouldNotImplement
]

{ #category : #DEPRECATED }
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

{ #category : #DEPRECATED }
GTExample >> gtDisplaySourceIn: composite [
	self deprecated: 'Please use #gtInspectorSourceIn: instead'.
	^ self gtInspectorSourceIn: composite
]

{ #category : #ui }
GTExample >> gtDisplaySummaryOn: aStream. [
	self label isEmptyOrNil 
		ifFalse: [ ^ aStream nextPutAll: self label ].
	self description isEmptyOrNil 
		ifFalse: [ ^ aStream nextPutAll: self description ].
	aStream nextPutAll: self method printString
]

{ #category : #'pragma-selectors' }
GTExample >> gtExample [
	<gtExamplePragma>
	<description: 'This method is turned into a gtExample if provided'>
	
	^ self
]

{ #category : #DEPRECATED }
GTExample >> gtExample: anObject [
	<toBeDeprecated: 'Please define your example-label (or description) using the pragma #label: or #description:'>
	self label: anObject.
	self gtExample
]

{ #category : #DEPRECATED }
GTExample >> gtExampleFrom: aSelector [
	self deprecated: 'Please define your example-dependencies using the pragma #depends: or #dependsClass:selector: or #dependsAll:'.
	self depends: aSelector
]

{ #category : #ui }
GTExample >> gtInspectorActionEvaluateResultAndGo [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :p | p selection: self result returnValue ];
		icon: (Smalltalk ui icons iconNamed: #glamorousRight);
		title: 'Evaluate result and go'
]

{ #category : #ui }
GTExample >> gtInspectorDependenciesIn: composite [
	<gtInspectorPresentationOrder: 2>
	self arguments ifEmpty: [ ^ self ].
	^ ((self dependenciesOrErrors ifEmpty: [ ^ self ]) gtInspectorItemsIn: composite)
			title: 'Dependencies'
]

{ #category : #ui }
GTExample >> gtInspectorDependentsIn: composite [
	<gtInspectorPresentationOrder: 3>
	self dependents ifEmpty: [ ^ self ].
	^ (self dependents gtInspectorItemsIn: composite)
			title: 'Dependents'
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
	self arguments ifEmpty: [ ^ self ].
	aStep listProcessor
		title: 'Example Dependencies';
		allCandidates: [ self arguments ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #ui }
GTExample >> gtSpotterDependentsFor: aStep [
	<spotterOrder: 101>
	self dependents ifEmpty: [ ^ self ].
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

{ #category : #ui }
GTExample >> gtSpotterProviderFor: aStep [
	<spotterOrder: 103>
	self provider ifNil: [ ^ self ].
	aStep listProcessor
		title: 'Example Provider';
		items: [ Array with: self provider ];
		itemName: [ :aProvider | aProvider gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #ui }
GTExample >> gtSpotterSourceFor: aStep [
	<spotterOrder: 103>
	self source ifNil: [ ^ self ].
	aStep listProcessor
		title: 'Example Source';
		items: [ Array with: self source ];
		itemName: [ :aSource | aSource gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #ui }
GTExample >> gtSpotterSubjectsFor: aStep [
	<spotterOrder: 102>
	self subjects ifEmpty: [ ^ self ].
	aStep listProcessor
		title: 'Example Subjects';
		allCandidates: [ self subjects ];
		itemName: [ :subject | subject gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #DEPRECATED }
GTExample >> hasDependencies [
	^ self arguments notEmpty
]

{ #category : #DEPRECATED }
GTExample >> hasDependency: anExample [
	(self traverser
		action: [ :example | (example equalsExample: anExample) ifTrue: [ ^ true ] ];
		yourself) value.
	^ false
]

{ #category : #DEPRECATED }
GTExample >> hasDependent [
	^ self dependents notEmpty
]

{ #category : #DEPRECATED }
GTExample >> hasDependent: anExample [
	(self traverser reversed
		action: [ :example | (example equalsExample: anExample) ifTrue: [ ^ true ] ];
		yourself) value.
	^ false
]

{ #category : #DEPRECATED }
GTExample >> hasDependents [
	^ self dependents notEmpty
]

{ #category : #DEPRECATED }
GTExample >> hasParentExample [
	self deprecated: 'Please use #hasDependent instead'.
	^ self hasDependent
]

{ #category : #DEPRECATED }
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

{ #category : #DEPRECATED }
GTExample >> hasValidAfterArguments [
	^ self after isNil
		or: [ self after hasValidArguments
			and: [ (self method variableNodes collect: [ :e | e name ]) includesAll: self after arguments ] ]
]

{ #category : #DEPRECATED }
GTExample >> hasValidArguments [
	^ self arguments size = self method numArgs
]

{ #category : #DEPRECATED }
GTExample >> hasValidDependencies [
	[ self dependencies ]
		on: Error
		do: [ ^ false ].
	^ true
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
	
	form := (self provider perform: aSelector)
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

{ #category : #DEPRECATED }
GTExample >> ignoreCache [
	^ self propertyAt: #noCache ifAbsent: [ false ]
]

{ #category : #DEPRECATED }
GTExample >> ignoreNotification [
	^ self propertyAt: #noNotification ifAbsent: [ false ]
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

{ #category : #DEPRECATED }
GTExample >> initializeFromFinder: aFinder withPragma: aPragma [
	finder := aFinder.
	pragma := aPragma.
	source := aFinder source.
	provider := aFinder provider.	
	subjects := aFinder subjects.
	exceptions := ExceptionSet new.
	children := OrderedCollection new.
	parents := Set new.
	properties := IdentityDictionary new.
	
	aPragma method pragmas do: [ :p |
		(self class canPerform: p keyword) 
			ifTrue: [ self perform: p keyword withArguments: p arguments ] ].
]

{ #category : #DEPRECATED }
GTExample >> initializeIconWith: aBlock [
	<todo: 'come up with something better than an empty & generic exception handler'>
	" We don't want to throw exceptions while examples are being created. We regard those as optional / nice-to-have. "
	[ aBlock value ]
		on: Error
		do: [ :exception | ]
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

{ #category : #DEPRECATED }
GTExample >> methodForClass: aClassOrClassName selector: aSelector [
	^ aClassOrClassName isClass 
		ifTrue: [ self methodForProvider: aClassOrClassName gtExamplesProvider selector: aSelector ]
		ifFalse: [ self methodForClassNamed: aClassOrClassName selector: aSelector ]
]

{ #category : #private }
GTExample >> methodForClassNamed: aClassOrClassName selector: aSelector [
	^ self classNamed: aClassOrClassName 
		do: [ :class | self methodForClass: class named: class name selector: aSelector ] 
		ifNone: [ self methodForClass: nil named: aClassOrClassName selector: aSelector ]
]

{ #category : #DEPRECATED }
GTExample >> methodForProvider: aProvider selector: aSelector [
	^ GTExampleProviderMethod new
		provider: aProvider;
		selector: aSelector asSymbol;
		yourself
]

{ #category : #private }
GTExample >> methodForSelector: aSelector [
	^ self methodForProvider: self provider selector: aSelector
]

{ #category : #DEPRECATED }
GTExample >> methodReference [
	self deprecated: 'The selector #methodReference is obsolete'.
	^ self method asRingDefinition
]

{ #category : #DEPRECATED }
GTExample >> noCache [
	<gtExamplePragma>
	<description: 'Never cache the result/returnValue of this example'>
	
	self propertyAt: #noCache put: true
]

{ #category : #DEPRECATED }
GTExample >> noNotification [
	<gtExamplePragma>
	<description: 'Do not show any notification for this example'>
	
	self propertyAt: #noNotification put: true
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

{ #category : #DEPRECATED }
GTExample >> parentExample: anObject [
	self deprecated: 'Please use #dependencies or #children instead'.
	self shouldNotImplement
]

{ #category : #DEPRECATED }
GTExample >> parents [
	^ parents
]

{ #category : #DEPRECATED }
GTExample >> pragma [
	^ pragma
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

{ #category : #public }
GTExample >> providerClass [
	^ self provider class
]

{ #category : #DEPRECATED }
GTExample >> proxyForClass: aClass selector: aSelector [
	" we have to resolve the kind of example again - it could be implemented in #class or in the provider of #class ! "
	^ self proxyForProvider: aClass gtExamplesProvider selector: aSelector
]

{ #category : #DEPRECATED }
GTExample >> proxyForProvider: aProvider selector: aSelector [
	^ GTExampleProxy new
		owner: self;
		provider: aProvider;
		selector: aSelector asSymbol;
		yourself
]

{ #category : #DEPRECATED }
GTExample >> proxyForSelector: aSelector [
	^ self proxyForProvider: self provider selector: aSelector
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

{ #category : #public }
GTExample >> removeFromSystem [
	self finder remove: self ifPresent: [ self detachFromSystem ]
]

{ #category : #DEPRECATED }
GTExample >> result [
	^ result ifNil: [ self run ]
]

{ #category : #DEPRECATED }
GTExample >> result: aResult [
	result := aResult
]

{ #category : #DEPRECATED }
GTExample >> resultCached [
	^ result
]

{ #category : #DEPRECATED }
GTExample >> resultCached: aResult [
	self ignoreCache ifFalse: [ result := aResult ].
	GTExampleNautilus methodUpdated: self method with: aResult.
	^ aResult
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

{ #category : #DEPRECATED }
GTExample >> source [
	^ source
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

{ #category : #DEPRECATED }
GTExample >> title [
	self deprecated: 'Please define your examples using pragmas'.
	^ self label
]

{ #category : #DEPRECATED }
GTExample >> title: aString [
	self deprecated: 'Please define your examples using pragmas'.
	self label: aString
]

{ #category : #'accessing-dynamic' }
GTExample >> traverser [
	^ GTExampleTraverser new 
		example: self;
		yourself
]
