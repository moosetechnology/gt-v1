Class {
	#name : #GTCachedCritics,
	#superclass : #Object,
	#instVars : [
		'packages',
		'classes',
		'classesWith',
		'methods',
		'results',
		'rules',
		'ruleFilter'
	],
	#classInstVars : [
		'cache'
	],
	#category : #'GT-SpotterExtensions-Core'
}

{ #category : #accessing }
GTCachedCritics class >> cache [ 
	^ cache ifNil: [ cache := self new ]
]

{ #category : #cleanup }
GTCachedCritics class >> cleanUp [
	self reset.
	cache := nil
]

{ #category : #public }
GTCachedCritics class >> reset [
	cache ifNotNil: [ cache reset ].
	Smalltalk garbageCollect.
]

{ #category : #'accessing-defaults' }
GTCachedCritics >> allRules [
	" By default we sort rules by priority (error > warning > information). This method is very expensive - the result should always be cached  "
	^ (((RBLintRule withAllSubclasses 
			select: [ :each | each isVisible ])
			collect: [ :each | each new ])
			reject: [ :each | each isTransformationRule ])
				sorted: [ :a :b | a gtSeverity < b gtSeverity ]
]

{ #category : #convenience }
GTCachedCritics >> checkErrorsAndWarningsOnly [
	self ruleFilter: [ :each | each severity = #warning or: [ each severity = #error ] ]
]

{ #category : #convenience }
GTCachedCritics >> checkErrorsOnly [
	self ruleFilter: [ :each | each severity = #error ]
]

{ #category : #convenience }
GTCachedCritics >> checkGroup: groupString checkCategory: categoryString checkSeverity: severitySymbol [
	self checkGroups: { groupString } checkCategories: { categoryString } checkSeverities: { severitySymbol }
]

{ #category : #convenience }
GTCachedCritics >> checkGroups: groupStrings checkCategories: categoryStrings checkSeverities: severitySymbols [
	self ruleFilter: [ :rule |
		(groupStrings isEmptyOrNil or: [ groupStrings includes: rule group ])
			and: [ (categoryStrings isEmptyOrNil or: [ categoryStrings includes: rule group ]) 
				and: [ (severitySymbols isEmptyOrNil or: [ severitySymbols includes: rule severity ]) ] ] ]
]

{ #category : #convenience }
GTCachedCritics >> checkInformationOnly [
	self ruleFilter: [ :each | each severity = #information ]
]

{ #category : #convenience }
GTCachedCritics >> checkWarningsOnly [
	self ruleFilter: [ :each | each severity = #warning ]
]

{ #category : #private }
GTCachedCritics >> class: aClass [
	^ self classes at: aClass name ifAbsentPut: [ RBClassEnvironment class: aClass ]
]

{ #category : #private }
GTCachedCritics >> class: aClass selector: aSelector [
	^ (self methods at: aClass name ifAbsentPut: [ IdentityDictionary new ])
		at: aSelector ifAbsentPut: [ RBSelectorEnvironment onMethods: { aSelector } forClass: aClass ]
]

{ #category : #private }
GTCachedCritics >> class: aClass with: aSelector [
	^ self class: aClass with: aSelector classes: (aClass perform: aSelector)
]

{ #category : #private }
GTCachedCritics >> class: aClass with: aSelector classes: aCollection [
	^ (self classesWith at: aClass name ifAbsentPut: [ IdentityDictionary new ])
		at: aSelector ifAbsentPut: [ RBClassEnvironment classes: aCollection ]
]

{ #category : #notifications }
GTCachedCritics >> classChanged: aClassAnnouncement [
	(aClassAnnouncement classAffected includesBehavior: RBLintRule) ifFalse: [ ^ self ].
	self resetAll
]

{ #category : #private }
GTCachedCritics >> classes [
	^ classes ifNil: [ classes := IdentityDictionary new ]
]

{ #category : #private }
GTCachedCritics >> classesWith [
	^ classesWith ifNil: [ classesWith := IdentityDictionary new ]
]

{ #category : #'accessing-defaults' }
GTCachedCritics >> defaultRuleFilter [
	^ [ :rule | true  ]
]

{ #category : #'accessing-defaults' }
GTCachedCritics >> defaultRules [
	^ self allRules select: self ruleFilter
]

{ #category : #initialization }
GTCachedCritics >> initialize [
	super initialize.
	
	SystemAnnouncer uniqueInstance weak 
		when: ClassAnnouncement send: #classChanged: to: self
]

{ #category : #private }
GTCachedCritics >> method: aCompiledMethod [
	^ self class: aCompiledMethod methodClass selector: aCompiledMethod selector
]

{ #category : #private }
GTCachedCritics >> methods [
	^ methods ifNil: [ methods := IdentityDictionary new ]
]

{ #category : #private }
GTCachedCritics >> package: aPackage [
	^ self packages at: aPackage packageName ifAbsentPut: [ RBPackageEnvironment package: aPackage ]
]

{ #category : #private }
GTCachedCritics >> packages [
	^ packages ifNil: [ packages := Dictionary new ]
]

{ #category : #initialization }
GTCachedCritics >> reset [
	classes := classesWith := methods := packages := results := nil.
	Smalltalk garbageCollect.
]

{ #category : #initialization }
GTCachedCritics >> resetAll [
	rules := nil.
	self reset.
]

{ #category : #private }
GTCachedCritics >> results [
	^ results ifNil: [ results := IdentityDictionary new ]
]

{ #category : #private }
GTCachedCritics >> results: aRule critics: aCritics ifPresent: aBlock1 ifAbsent: aBlock2 [
	| cache |
	^ aBlock1 value: ((cache := self results at: aRule class name ifAbsentPut: [ IdentityDictionary new ])
		at: aCritics environment 
		ifAbsent: [ 
			cache at: aCritics environment  put: aRule.
			[ aBlock2 value ] 
				on: Error 
				do: [ " ignore errors " ].
			aRule ])
]

{ #category : #accessing }
GTCachedCritics >> ruleFilter [
	^ ruleFilter ifNil: [ ruleFilter := self defaultRuleFilter ]
]

{ #category : #accessing }
GTCachedCritics >> ruleFilter: anObject [
	ruleFilter := anObject.
	self resetAll.
]

{ #category : #accessing }
GTCachedCritics >> rules [
	^ rules ifNil: [ rules := self defaultRules ]
]
