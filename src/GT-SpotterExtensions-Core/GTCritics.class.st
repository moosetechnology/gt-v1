Class {
	#name : #GTCritics,
	#superclass : #Object,
	#instVars : [
		'environment',
		'rules',
		'title'
	],
	#category : #'GT-SpotterExtensions-Core'
}

{ #category : #accessing }
GTCritics class >> cache [
	^ GTCachedCritics cache
]

{ #category : #public }
GTCritics class >> forClass: aClass [
	| subs |
	subs := aClass allSubclasses.
	^ {	self onClass: aClass. 
		self onClass: aClass withAll: subs. 
		self onClass: aClass all: subs }
]

{ #category : #public }
GTCritics class >> onClass: aClass [
	^ self new 
		title: aClass name;
		environment: (self cache class: aClass);
		yourself
]

{ #category : #private }
GTCritics class >> onClass: aClass all: aCollection [
	^ self new 
		title: 'Subclasses';
		environment: (self cache class: aClass with: #allSubclasses classes: aCollection);
		yourself
	
	
]

{ #category : #private }
GTCritics class >> onClass: aClass withAll: aCollection [
	^ self new 
		title: 'With all subclasses';
		environment: (self cache class: aClass with: #withAllSubclasses classes: {aClass}, aCollection);
		yourself
	
	
]

{ #category : #public }
GTCritics class >> onMethod: aCompiledMethod [
	^ self new 
		title: (String streamContents: [ :stream | aCompiledMethod printOn: stream ]);
		environment: (self cache method: aCompiledMethod);
		yourself
]

{ #category : #public }
GTCritics class >> onPackage: anRPackage [
	^ self new 
		title: anRPackage packageName;
		environment: (self cache package: anRPackage);
		yourself
]

{ #category : #public }
GTCritics class >> onSubclasses: aClass [
	^ self new 
		title: 'Subclasses';
		environment: (self cache class: aClass with: #allSubclasses);
		yourself
	
	
]

{ #category : #public }
GTCritics class >> onWithSubclasses: aClass [
	^ self new 
		title: 'With all subclasses';
		environment: (self cache class: aClass with: #withAllSubclasses);
		yourself
	
	
]

{ #category : #accessing }
GTCritics >> cache [
	^ self class cache
]

{ #category : #'accessing-defaults' }
GTCritics >> defaultRules [
	^ self cache rules
]

{ #category : #accessing }
GTCritics >> environment [
	^ environment
]

{ #category : #accessing }
GTCritics >> environment: anObject [
	environment := anObject
]

{ #category : #private }
GTCritics >> filter: filter context: context [
	'Running Critics ...' displayProgressFrom: 0 to: self rules size during: [ :bar |
		self rules withIndexDo: [ :rule :index | 
			| newRule |
			self cache 
				results: (newRule := rule class new) 
				critics: self
				ifPresent: [ :existingRule | 
					(existingRule isEmpty or: [ existingRule problemCount < 1 ])
						ifFalse: [ filter value: existingRule ] ] 
				ifAbsent: [ 
					[ bar current: index; label: index asString, '/', self rules size asString, ' ', newRule name asString ]
						on: Error 
						do: [ " ignore errors by morphics " ].
					[ RBSmalllintChecker runRule: newRule onEnvironment: self environment ]
						on: Error
						do: [ " ignore errors by lint " ] ] ] ]
]

{ #category : #private }
GTCritics >> itemIconFor: each [
	(each severity = #error) ifTrue: [ ^ Smalltalk ui icons glamorousSmallCriticsErrorIcon ].
	(each severity = #warning) ifTrue: [ ^ Smalltalk ui icons glamorousSmallCriticsWarningIcon ]. 
	^ Smalltalk ui icons glamorousSmallCriticsInformationIcon
]

{ #category : #printing }
GTCritics >> printOn: stream [
	stream nextPutAll: self title
]

{ #category : #accessing }
GTCritics >> rules [
	^ rules ifNil: [ rules := self defaultRules ]
]

{ #category : #accessing }
GTCritics >> rules: anObject [
	rules := anObject
]

{ #category : #private }
GTCritics >> spotterActDefault [
	self cache reset.
	self inform: 'Critics results cleared - dive for refresh'
]

{ #category : #private }
GTCritics >> spotterActDefault: aStep [
	self spotterActDefault
]

{ #category : #private }
GTCritics >> spotterCriticsFor: aStep [
	<spotterOrder: 1>
	aStep listProcessor
		title: 'Critics Results';
		itemName: [ :each | each class uniqueIdentifierName, ' (', each problemCount asString, ')' ];
		itemIcon: [ :each | self itemIconFor: each ];
		filter: GTFilterSubstring item: [ :filter :context | self filter: filter context: context ];
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #accessing }
GTCritics >> title [
	^ title
]

{ #category : #accessing }
GTCritics >> title: anObject [
	title := anObject
]
