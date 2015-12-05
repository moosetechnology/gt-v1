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
		'result',
		'properties'
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
	self deprecated: 'Please define your examples using pragmas'.
	^ self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> extractionStrategy: anObject [
	self deprecated: 'Please define your examples using pragmas'.
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
	^ self
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> gtExample: anObject [
	<toBeDeprecated: 'Please define your example-label (or description) using the pragma #label: or #description:'>
	self label: anObject.
	self gtExample
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> gtExampleFrom: aSelector [
	self deprecated: 'Please define your example-dependencies using the pragma #depends: or #dependsClass:selector: or #dependsAll:'.
	self depends: aSelector
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

{ #category : #testing }
GTExample >> hasDependencies [
	^ self arguments notEmpty
]

{ #category : #testing }
GTExample >> hasDependency: anExample [
	(self traverser
		action: [ :example | (example equalsExample: anExample) ifTrue: [ ^ true ] ];
		yourself) value.
	^ false
]

{ #category : #testing }
GTExample >> hasDependent [
	^ self dependents notEmpty
]

{ #category : #testing }
GTExample >> hasDependent: anExample [
	(self traverser reversed
		action: [ :example | (example equalsExample: anExample) ifTrue: [ ^ true ] ];
		yourself) value.
	^ false
]

{ #category : #testing }
GTExample >> hasDependents [
	^ self dependents notEmpty
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> hasParentExample [
	self deprecated: 'Please use #hasDependent instead'.
	^ self hasDependent
]

{ #category : #testing }
GTExample >> hasRelationships [
	^ self hasDependents
		or: [ self hasDependencies ]
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
GTExample >> iconSelectorBase64: aSelector [
	self iconBase64: (self provider perform: aSelector)
]

{ #category : #'pragma-selectors' }
GTExample >> iconThemeSelector: aSelector [
	form := (Smalltalk ui icons perform: aSelector)
]

{ #category : #testing }
GTExample >> ignoreCache [
	^ self propertyAt: #noCache ifAbsent: [ false ]
]

{ #category : #testing }
GTExample >> ignoreTest [
	^ self propertyAt: #noTest ifAbsent: [ false ]
]

{ #category : #testing }
GTExample >> ignoreTestReport [
	^ self propertyAt: #notTestReport ifAbsent: [ false ]
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
	properties := IdentityDictionary new.
	
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
	self deprecated: 'The selector #methodReference is obsolete'.
	^ self method asRingDefinition
]

{ #category : #'pragma-selectors' }
GTExample >> noCache [
	self propertyAt: #noCache put: true
]

{ #category : #'pragma-selectors' }
GTExample >> noTest [
	self propertyAt: #noTest put: true
]

{ #category : #'pragma-selectors' }
GTExample >> notTestReport [
	self propertyAt: #notTestReport put: true
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> parentExample: anObject [
	self deprecated: 'Please use #dependencies or #children instead'.
	self shouldNotImplement
]

{ #category : #private }
GTExample >> parents [
	^ parents
]

{ #category : #accessing }
GTExample >> pragma [
	^ pragma
]

{ #category : #public }
GTExample >> propertyAt: aKey [
	^ (properties ifNil: [ KeyNotFound signalFor: aKey ])
		at: aKey
]

{ #category : #public }
GTExample >> propertyAt: aKey ifAbsent: aBlock [
	^ (properties ifNil: [ ^ aBlock value ])
		at: aKey ifAbsent: aBlock
]

{ #category : #public }
GTExample >> propertyAt: aKey ifAbsentPut: aBlock [
	^ (properties ifNil: [ properties := IdentityDictionary new ])
		at: aKey ifAbsentPut: aBlock
]

{ #category : #public }
GTExample >> propertyAt: aKey put: aValue [
	^ (properties ifNil: [ properties := IdentityDictionary new ])
		at: aKey put: aValue
]

{ #category : #accessing }
GTExample >> provider [
	^ provider
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> provider: aClassOrInstance [
	self deprecated: 'Please define your examples using pragmas'.
	self shouldNotImplement
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

{ #category : #public }
GTExample >> removeFromSystem [
	self finder remove: self ifPresent: [ self detachFromSystem ]
]

{ #category : #accessing }
GTExample >> result [
	^ result ifNil: [ self run ]
]

{ #category : #private }
GTExample >> result: aResult [
	result := aResult
]

{ #category : #private }
GTExample >> resultCached [
	^ result
]

{ #category : #private }
GTExample >> resultCached: aResult [
	self ignoreCache ifFalse: [ result := aResult ].
	GTExampleNautilus methodUpdated: self method with: aResult.
	^ aResult
]

{ #category : #public }
GTExample >> returnValue [
	^ self result returnValue
]

{ #category : #private }
GTExample >> run [
	^ self resultCached: self evaluator result 
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> selector [
	self deprecated: 'Please define your examples using pragmas'.
	^ self shouldNotImplement
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> selector: aSelector [
	self deprecated: 'Please define your examples using pragmas'.
	self shouldNotImplement
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
	^ self gtSpotterPreviewIn: aComposite
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
	self deprecated: 'Please define your examples using pragmas'.
	^ self label
]

{ #category : #'*GT-Inspector-Examples-DEPRECATED' }
GTExample >> title: aString [
	self deprecated: 'Please define your examples using pragmas'.
	self label: aString
]

{ #category : #public }
GTExample >> traverser [
	^ GTExampleTraverser new 
		example: self;
		yourself
]
