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
	#traits : 'TGTExampleMethod',
	#classTraits : 'TGTExampleMethod classTrait',
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
		'problems',
		'extensions'
	],
	#category : #'GT-Examples-Core'
}

{ #category : #testing }
GTExample >> = anExample [
	^ self class = anExample class 
		and: [ self methodClass = anExample methodClass 
			and: [ self selector = anExample selector ] ]
]

{ #category : #private }
GTExample >> addChild: aGTDependency [
	children add: aGTDependency
]

{ #category : #private }
GTExample >> addExtension: anExtension [
	extensions add: anExtension
]

{ #category : #private }
GTExample >> addProblem: aProblem [
	problems add: aProblem
]

{ #category : #private }
GTExample >> addSubject: aGTExampleSubject [
	subjects add: aGTExampleSubject asGTExampleSubject
]

{ #category : #accessing }
GTExample >> after [
	^ after
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> after: aSelector [
	<gtExamplePragma>
	<description: 'A method, implemented by the given selector, to be performed after this example has run ~ similar but not identical to teardown of sunit'>
	
	after := self methodResolverClass resolve: GTExampleMethodAfter example: self selector: aSelector
]

{ #category : #'accessing-dynamic' }
GTExample >> afterArguments [
	self after ifNil: [ ^ #() ].
	^ self after arguments
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> afterClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'A method, implemented by (aClassOrClassName >> aSelector), to be performed after this example has run ~ similar but not identical to teardown of sunit'>
	
	after := self methodResolverClass resolve: GTExampleMethodAfter example: self className: aClassOrClassName meta: false selector: aSelector
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> afterMetaClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'A method, implemented by (aClassOrClassName >> aSelector), to be performed after this example has run ~ similar but not identical to teardown of sunit'>
	
	after := self methodResolverClass resolve: GTExampleMethodAfter example: self className: aClassOrClassName meta: true selector: aSelector
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

{ #category : #DEPRECATED }
GTExample >> classNamed: aClassOrClassName [
	self deprecated: 'use GTExampleClassResolver instead'.
	^ (self classResolverClass
		theClassName: aClassOrClassName;
		meta: false; " lucky guess "
		yourself) theClassDo: [ :class | class ] ifNone: [ nil ]
]

{ #category : #DEPRECATED }
GTExample >> classNamed: aClassName do: aBlock [
	self deprecated: 'use GTExampleClassResolver instead'.
	^ (self classResolverClass
		theClassName: aClassName;
		meta: false; " lucky guess "
		yourself) theClassDo: aBlock
]

{ #category : #DEPRECATED }
GTExample >> classNamed: aClassName do: aBlock1 ifNone: aBlock2 [
	self deprecated: 'use GTExampleClassResolver instead'.
	(self classResolverClass
		theClassName: aClassName;
		meta: false; " lucky guess "
		yourself) theClassDo: aBlock1 ifNone: aBlock2
]

{ #category : #private }
GTExample >> classResolverClass [
	^ GTExampleClassResolver
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

{ #category : #DEPRECATED }
GTExample >> depends: aSelector [
	self deprecated: 'use #dependsOn: instead'.
	self dependsOn: aSelector
]

{ #category : #DEPRECATED }
GTExample >> dependsAll: aString [
	self deprecated: 'use #dependsOnAll: instead'.
	self dependsOnAll: aString
]

{ #category : #DEPRECATED }
GTExample >> dependsClass: aClassOrClassName selector: aSelector [
	self deprecated: 'use #dependsOnClass:selector: instead'.
	self dependsOnClass: aClassOrClassName selector: aSelector
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> dependsOn: aSelector [
	<gtExamplePragma>
	<description: 'This example depends on the example declared by the given selector. Any dependency will be performed before this example is performed. Order of declaration is important'>
	
	self addChild: (self methodResolverClass resolve: GTExampleMethod example: self selector: aSelector)
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> dependsOnAll: aString [
	<gtExamplePragma>
	<description: 'This example depends on all given selectors found in the given string (list separated by  .,;). Any dependency will be performed before this example is performed. Order of declaration is important'>
	
	self substrings: aString do: [ :each | 
		self dependsOn: aString ]
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> dependsOnClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'This example depends on the example declared by the given class and selector. Any dependency will be performed before this example is performed. Order of declaration is important'>
	
	children add: (self methodResolverClass resolve: GTExampleMethod example: self className: aClassOrClassName meta: false selector: aSelector)
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> dependsOnMetaClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'This example depends on the example declared by the given meta-class and selector. Any dependency will be performed before this example is performed. Order of declaration is important'>
	
	children add: (self methodResolverClass resolve: GTExampleMethod example: self className: aClassOrClassName meta: true selector: aSelector)
]

{ #category : #accessing }
GTExample >> description [
	^ description
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> description: aString [
	<gtExamplePragma>
	<description: 'A full description of this example'>
	
	description := aString
]

{ #category : #TODO }
GTExample >> directDependents [
	<todo: 'better name -> #myDependents and #dependents is taken - wtf!'>
	^ (GTExampleOrganizer instance examplesSelect: [ :each | each hasDependency: self ]) asSet asArray
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

{ #category : #private }
GTExample >> form [
	^ form
]

{ #category : #private }
GTExample >> form: anIcon [
	form := anIcon
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> gtExample [
	<gtExamplePragma>
	<description: 'This method is turned into a gtExample if provided'>
	
	^ self
]

{ #category : #'PRAGMA-SELECTORS' }
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

{ #category : #testing }
GTExample >> hasAfter [
	^ after notNil
]

{ #category : #testing }
GTExample >> hasAfter: anAfterMethod [
	^ after = anAfterMethod
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
	^ self arguments anySatisfy: [ :each | each matchesMethod: aGTExample ]
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
GTExample >> hasExtensions [
	^ extensions isEmptyOrNil not
]

{ #category : #testing }
GTExample >> hasInternalProblems [
	^ problems notEmpty
]

{ #category : #testing }
GTExample >> hasLiteralThorough: aLiteral [
	^ self methodClass = aLiteral
		or: [ self selector = aLiteral
			or: [ (self label notNil and: [ self label includesSubstring: aLiteral asString caseSensitive: false ])
				or: [ (self description notNil and: [ self description includesSubstring: aLiteral asString caseSensitive: false ])
					or: [ (self subjects anySatisfy: [ :each | each hasLiteralThorough: aLiteral ])
						or: [ self exists and: [ (self method hasLiteralThorough: aLiteral asSymbol) or: [ self method hasLiteralThorough: aLiteral asSymbol ] ] ] ] ] ] ]
]

{ #category : #testing }
GTExample >> hasProblems [
	^ problems notEmpty
		or: [ self hasValidArguments not
			or: [  self hasValidAfter not
				or: [ self hasValidDependencies not ] ] ]
]

{ #category : #testing }
GTExample >> hasRelationships [
	^ self hasDependents
		or: [ self hasDependencies ]
]

{ #category : #testing }
GTExample >> hasSubject: aSubject [
	^ self subjects anySatisfy: [ :each | 
		each == aSubject 
			or: [ each = aSubject ] ]
]

{ #category : #testing }
GTExample >> hasSubjectMatching: aStringOrSubject [
	^ (self hasSubject: aStringOrSubject)
		or: [ self subjects anySatisfy: [ :each | 
			each hasLiteralThorough: aStringOrSubject ] ]
]

{ #category : #testing }
GTExample >> hasSubjects [
	^ self subjects notEmpty
]

{ #category : #testing }
GTExample >> hasValidAfter [
	^ self hasAfter not
		or: [ self after isValid ]
]

{ #category : #testing }
GTExample >> hasValidArguments [
	^ self arguments size = self method numArgs
]

{ #category : #testing }
GTExample >> hasValidDependencies [
	^ self hasValidArguments 
		and: [ self hasDependencies not
			or: [ self dependencies allSatisfy: [ :each | 
				each notNil and: [ each exists ] ] ] ]
]

{ #category : #testing }
GTExample >> hasValidExtensions [
	^ self hasExtensions not
		or: [ extensions allSatisfy: [ :each | 
				each notNil and: [ each isValid ] ] ]
]

{ #category : #testing }
GTExample >> hash [
	^ (self class hash 
		bitXor: self methodClass hash) 
			bitXor: self selector hash
]

{ #category : #accessing }
GTExample >> icon [
	^ form ifNotNil: [ form form ]
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> icon: aSelector [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The selector must be implemented by the currently active theme'>

	self iconThemeSelector: aSelector
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> iconBase64: aString [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The icon form is described by the given base64-encoded string'>
	
	form := GTExampleFormIcon fromBase64String: aString
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> iconBytes: aByteArray [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The icon form is described by the given byte-array'>
	
	form := GTExampleFormIcon fromByteArray: aByteArray
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> iconClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The method described by the given class and selector must return an icon form'>
	
	form := self methodResolverClass resolve: GTExampleMethodIcon example: self className: aClassOrClassName meta: false selector: aSelector
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> iconMetaClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The method described by the given meta-class and selector must return an icon form'>
	
	form := self methodResolverClass resolve: GTExampleMethodIcon example: self className: aClassOrClassName meta: true selector: aSelector
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> iconSelector: aSelector [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The selector must return an icon form'>
	
	form := (self methodResolverClass resolve: GTExampleMethodIcon example: self selector: aSelector)
		converter: #convertFromByteArray:;
		yourself
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> iconSelectorBase64: aSelector [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The icon form is described by the base64 string returned by the given selector'>
	
	form := (self methodResolverClass resolve: GTExampleMethodIcon example: self selector: aSelector)
		converter: #convertFromBase64String:;
		yourself
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> iconThemeSelector: aSelector [
	<gtExamplePragma>
	<description: 'Attach an icon to this example. The selector must be implemented by the currently active theme'>
	
	form := GTExampleThemeIcon fromSelector: aSelector
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
	
	children := OrderedCollection new.
	subjects := Set new.
	problems := Set new.
	exceptions := ExceptionSet new.	
	properties := IdentityDictionary new.
	extensions := Set new.
]

{ #category : #initializing }
GTExample >> initializeFromMethod: aCompiledMethod usingFactory: aGTExampleFactory [
	methodClass := aCompiledMethod methodClass.
	selector := aCompiledMethod selector.
	aGTExampleFactory initializeExample: self fromMethod: aCompiledMethod
]

{ #category : #'accessing-dynamic' }
GTExample >> invalidArguments [
	^ self arguments reject: [ :each | each isValid ]
]

{ #category : #'accessing-dynamic' }
GTExample >> invalidDependencies [
	^ self arguments reject: [ :each | each isValid or: [ each exists ] ]
]

{ #category : #testing }
GTExample >> isGTExample [
	^ true
]

{ #category : #testing }
GTExample >> isReferencing: aLiteral [
	^ (self hasSubject: aLiteral)
		or: [ (self subjects anySatisfy: [ :subject | subject hasLiteralThorough: aLiteral ])
			or: [ (self exists and: [ self method hasLiteralThorough: aLiteral ])
				or: [ (self methodClass name asString = aLiteral asString) ] ] ]
]

{ #category : #testing }
GTExample >> isValid [
	^ self hasProblems not
		and: [ self traverser canProcess ]
]

{ #category : #accessing }
GTExample >> label [
	^ label
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> label: aString [
	<gtExamplePragma>
	<description: 'A short identifier = name of this example'>
	
	label := aString
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

{ #category : #DEPRECATED }
GTExample >> method: aMethodClass forClass: aClass named: aClassName selector: aSelector [
	self deprecated: 'use GTExampleMethodResolver instead'.
	^ self methodResolverClass resolve: aMethodClass example: self className: (aClass ifNotNil: [ aClass name ] ifNil: [ aClassName ]) meta: (aClass ifNotNil: [ aClass isMeta ] ifNil: [ false " lucky guess " ]) selector: aSelector
]

{ #category : #DEPRECATED }
GTExample >> method: aGTExampleMethodClass forClass: aClass selector: aSelector [
	self deprecated: 'use GTExampleMethodResolver instead'.
	^ self methodResolverClass resolve: aGTExampleMethodClass example: self className: aClass meta: aClass isMeta selector: aSelector
]

{ #category : #DEPRECATED }
GTExample >> method: aMethodClass forClassNamed: aClassOrClassName selector: aSelector [
	self deprecated: 'use GTExampleMethodResolver instead'.
	^ self methodResolverClass resolve: aMethodClass example: self className: aClassOrClassName meta: false " lucky guess " selector: aSelector
]

{ #category : #DEPRECATED }
GTExample >> method: aMethodClass forSelector: aSelector [
	self deprecated: 'use GTExampleMethodResolver instead'.
	self method: aMethodClass forClass: self methodClass selector: aSelector
	
]

{ #category : #'accessing-dynamic' }
GTExample >> methodArgumentNames [
	^ self exists
		ifTrue: [ self method argumentNames ]
		ifFalse: [ #() ]
]

{ #category : #accessing }
GTExample >> methodClass [
	^ methodClass
]

{ #category : #'accessing-dynamic' }
GTExample >> methodReference [
	^ self method asRingDefinition
]

{ #category : #private }
GTExample >> methodResolverClass [
	^ GTExampleMethodResolver
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> noTest [
	<gtExamplePragma>
	<description: 'Do not run this example while running SUnit tests'>
	
	self propertyAt: #noTest put: true
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> noTestReport [
	<gtExamplePragma>
	<description: 'Do not run this example while running HDTestReport (not yet implemented)'>
	
	self propertyAt: #noTestReport put: true
]

{ #category : #accessing }
GTExample >> problems [
	" some problems are static -> #problems / other problems are dynamic (and changing) and not stored in #problems -> arguments+examples "
	^ (problems , self invalidArguments) asArray
]

{ #category : #accessing }
GTExample >> propertyAt: aKey [
	^ properties at: aKey
]

{ #category : #accessing }
GTExample >> propertyAt: aKey ifAbsent: aBlock [
	^ properties at: aKey ifAbsent: aBlock
]

{ #category : #accessing }
GTExample >> propertyAt: aKey ifAbsentPut: aBlock [
	^ properties at: aKey ifAbsentPut: aBlock
]

{ #category : #accessing }
GTExample >> propertyAt: aKey put: aValue [
	^ properties at: aKey put: aValue
]

{ #category : #'accessing-dynamic' }
GTExample >> provider [ 
	^ self methodClass isMeta
		ifTrue: [ self methodClass theNonMetaClass ]
		ifFalse: [ self methodClass theNonMetaClass new ]
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> raises: aClassOrClassName [
	<gtExamplePragma>
	<description: 'This example is expected to raise the given exception. The example (as a test) will fail if the exception is not raised.'>
	(self classResolverClass new
		theClassName: aClassOrClassName;
		meta: false;
		yourself) theClassDo: [ :class | self exceptions add: class ]
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> raisesAny: aString [
	<gtExamplePragma>
	<description: 'This example is expected to raise any of the given exceptions (list separated by  .,;). The example (as a test) will fail if none of the exceptions is raised.'>
	
	self substrings: aString do: [ :each | 
		self raises: each ]
]

{ #category : #initializing }
GTExample >> reinitialize [
	| method |
	(method := self method) ifNil: [ ^ self ].
	
	self initialize.
	method gtExamplesFactory initializeExample: self fromMethod: method
]

{ #category : #'accessing-dynamic' }
GTExample >> result [
	^ self run
]

{ #category : #'accessing-dynamic' }
GTExample >> returnValue [
	^ self result returnValue
]

{ #category : #actions }
GTExample >> run [
	^ self evaluator result 
]

{ #category : #actions }
GTExample >> runThenDo: aBlock1 onErrorDo: aBlock2 [
	| result |
	^ (result := self run) isSuccess 
		ifTrue: [ aBlock1 value: result ]
		ifFalse: [ aBlock2 value: result ]
]

{ #category : #accessing }
GTExample >> selector [
	^ selector
]

{ #category : #'accessing-dynamic' }
GTExample >> signalableExceptions [
	^ self exceptions copyWithAll: { Halt. Error. Exit. UnhandledError. TestFailure. Deprecation. }
]

{ #category : #'accessing-dynamic' }
GTExample >> sourceCode [
	^ self method sourceCode
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subject: aClassOrClassName [
	<gtExamplePragma>
	<description: 'Add a class-subject to the example'>
	
	self subjectClass: aClassOrClassName
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectClass: aClassOrClassName [
	<gtExamplePragma>
	<description: 'Add a class-subject to the example'>
	
	self addSubject: (self classResolverClass resolve: GTExampleClassSubject example: self className: aClassOrClassName meta: false)
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'Add a method-subject to the example'>
	
	self addSubject: (self methodResolverClass resolve: GTExampleMethodSubject example: self className: aClassOrClassName meta: false selector: aSelector)
]

{ #category : #DEPRECATED }
GTExample >> subjectForClassNamed: aClassName [
	self deprecated: 'use GTExampleClassResolver instead'.
	^ (self classResolverClass
		theClassName: aClassName;
		meta: false; " lucky guess "
		yourself) theClassDo: [ :class | class ] ifNone: [ nil ]
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectHelp: bookName [
	<gtExamplePragma>
	<description: 'Add a help/topic-subject to the example'>
	
	self subjectHelp: bookName title: nil
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectHelp: bookName title: title [
	<gtExamplePragma>
	<description: 'Add a help/topic-subject to the example'>
	
	self addSubject: (GTExampleHelpSubject fromBook: bookName title: title)
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectKeyword: aStringOrSymbol [
	<gtExamplePragma>
	<description: 'Add a keyword to the example'>
	
	self addSubject: (GTExampleKeywordSubject fromString: aStringOrSymbol)
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectKeywords: anArrayOrString [
	<gtExamplePragma>
	<description: 'Add multiple keywords to the example'>
	
	anArrayOrString gtExampleSubstrings do: [ :each |
		self subjectKeyword: each ]
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectMetaClass: aClassOrClassName [
	<gtExamplePragma>
	<description: 'Add a meta-class-subject to the example'>
	
	self addSubject: (self classResolverClass resolve: GTExampleClassSubject example: self className: aClassOrClassName meta: true)
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectMetaClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'Add a method-subject to the example'>
	
	self addSubject: (self methodResolverClass resolve: GTExampleMethodSubject example: self className: aClassOrClassName meta: true selector: aSelector)
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectPackage: packageName [
	<gtExamplePragma>
	<description: 'Add a package-subject to the example'>
	
	self addSubject: (GTExamplePackageSubject fromPackageNamed: packageName)
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectSelector: aSelector [
	<gtExamplePragma>
	<description: 'Add a selector subject to the example'>
	
	self addSubject: (GTExampleSelectorSubject fromString: aSelector)
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectTag: tagName [
	<gtExamplePragma>
	<description: 'Add a tag-subject to the example'>
	
	self addSubject: (GTExampleTagSubject fromTagNamed: tagName)
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectText: aString [
	<gtExamplePragma>
	<description: 'Add a text-subject to the example'>
	
	self addSubject: (GTExampleTextSubject fromText: aString)
]

{ #category : #accessing }
GTExample >> subjects [
	^ subjects asArray
]

{ #category : #'PRAGMA-SELECTORS' }
GTExample >> subjectsAll: aString [
	<gtExamplePragma>
	<description: 'Add multiple class-subjects (list separated by  .,;) to the example'>
	
	self substrings: aString do: [ :each | 
		self subject: each ]
]

{ #category : #private }
GTExample >> substrings: aString do: aBlock [
	aString gtExampleSubstrings do: [ :each | 
		aBlock value: each ]
]

{ #category : #'accessing-dynamic' }
GTExample >> traverser [
	^ GTExampleTraverser new 
		example: self;
		yourself
]
