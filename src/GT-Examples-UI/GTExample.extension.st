Extension { #name : #GTExample }

{ #category : #'*GT-Examples-UI' }
GTExample >> gtDebuggerSourceIn: composite [
	<gtDebuggerPresentationOrder: 1>
	self exists ifFalse: [ ^ self ].
	^ (self method gtInspectorSourceIn: composite)
		title: 'Method'
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtDisplayOn: aStream [
	self label isEmptyOrNil 
		ifTrue: [ 
			aStream 
				print: self methodClass; 
				nextPutAll: ' >> '; 
				print: self selector ]
		ifFalse: [ 
			aStream nextPutAll: self label ].
		
	self gtDisplayValidityOn: aStream
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtDisplayValidityOn: aStream [
	self isValid ifTrue: [ ^ self ].
	
	aStream nextPutAll: ' [invalid]'
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorActionReturnValue [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ :p | p selection: (self runThenDo: [ :r | r returnValue ] onErrorDo: [ :r | r ]) ];
		icon: (Smalltalk ui icons iconNamed: #glamorousGo);
		title: 'Evaluate and inspect return-value'
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorActionSubjects [
	<gtInspectorAction>
	^ GLMGenericAction new
		action: [ GTExampleNavigation browseAllExampleSubjects: { self } ];
		icon: (Smalltalk ui icons iconNamed: #glamorousBookmark);
		title: 'Subjects'
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorActions [
	^ super gtInspectorActions 
		addAll: self gtInspectorCustomActions;
		yourself
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorAfterIn: composite [
	<gtInspectorPresentationOrder: 3>
	self hasAfter ifFalse: [ ^ self ].
	^ ({ self after } gtInspectorItemsIn: composite)
			title: 'After'
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorCustomActions [
	self hasExtensions ifFalse: [ ^ { } ].
	
	^ Array streamContents: [ :stream | 
		extensions do: [ :each | 
			(each gtInspectorActionFor: self) ifNotNil: [ :action |
				stream nextPut: action ] ] ] 
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorCustomExtensionsFor: composite [
	<gtInspectorPresentationOrder: 99>
	self hasExtensions ifFalse: [ ^ self ].
	
	extensions do: [ :extension |
		extension gtInspectorFor: composite example: self ]
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorDependenciesIn: composite [
	<gtInspectorPresentationOrder: 1>
	self hasDependencies ifFalse: [ ^ self ].
	^ (self dependenciesOrArguments gtInspectorItemsIn: composite)
			title: 'Dependencies'
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorDependentsIn: composite [
	<gtInspectorPresentationOrder: 2>
	self hasDependents ifFalse: [ ^ self ].
	^ (self directDependents gtInspectorItemsIn: composite)
			title: 'Dependents'
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorMethodIn: composite [
	<gtInspectorPresentationOrder: 0>
	self exists ifFalse: [ ^ self ].
	^ (self method gtInspectorSourceIn: composite)
		title: 'Method'
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorProblemsIn: composite [
	<gtInspectorPresentationOrder: 5>
	self hasProblems ifFalse: [ ^ self ].
	^ (self problems gtInspectorItemsIn: composite)
			title: 'Problems'
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorRoassalIn: composite [
	<gtInspectorPresentationOrder: 1>
	self hasDependencies ifFalse: [ ^ self ].
	(Smalltalk classNamed: #GLMRoassal2Presentation) ifNil: [ ^ self ].
	^ composite roassal2
		title: 'Graph';
		painting: [ :view :example | 
			(GTExampleGraphPainter new 
				example: example;
				view: view;
				yourself) paint ];
		yourself
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ (self method gtInspectorSourceIn: composite)
		title: 'Source'
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtInspectorSubjectsIn: composite [
	<gtInspectorPresentationOrder: 4>
	self hasSubjects ifFalse: [ ^ self ].
	^ (self subjects gtInspectorItemsIn: composite)
			title: 'Subjects'
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtSpotterAfterFor: aStep [
	<spotterOrder: 3>
	self hasAfter ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'Example After';
		items: [ { self after } ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtSpotterCustomExtensionsFor: aStep [
	<spotterOrder: 99>
	self hasExtensions ifFalse: [ ^ self ].
	
	extensions do: [ :extension |
		extension gtSpotterFor: aStep example: self ]
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtSpotterDependenciesFor: aStep [
	<spotterOrder: 1>
	self hasDependencies ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'Example Dependencies';
		items: [ self dependenciesOrArguments ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtSpotterDependentsFor: aStep [
	<spotterOrder: 2>
	self hasDependents ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'Example Dependents';
		items: [ self directDependents ];
		itemName: [ :example | example gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtSpotterGTExampleSubjectsFor: aStep [
	<spotterOrder: 4>
	self hasSubjects ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'Example Subjects';
		items: [ self subjects asArray ];
		itemName: [ :subject | subject gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtSpotterMethodFor: aStep [
	<spotterOrder: 0>
	self exists ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'Method';
		items: [ Array with: self method ];
		itemName: [ :aSource | aSource gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #'*GT-Examples-UI' }
GTExample >> gtSpotterProblemsFor: aStep [
	<spotterOrder: 5>
	self hasProblems ifFalse: [ ^ self ].
	aStep listProcessor
		title: 'Example Problems';
		items: [ self problems ];
		itemName: [ :problem | problem gtDisplayString ];
		filter: GTFilterSubstring
]

{ #category : #'*GT-Examples-UI-PRAGMA-SELECTORS' }
GTExample >> inspector: aSelector [
	<gtExamplePragma>
	<description: 'A method providing a custom GTInspector-extensions for this particular example'>
	
	self addExtension: (self methodResolverClass resolve: GTExampleMethodInspectorExtension example: self selector: aSelector)
]

{ #category : #'*GT-Examples-UI-PRAGMA-SELECTORS' }
GTExample >> inspectorAction: aSelector [
	<gtExamplePragma>
	<description: 'A method providing a custom GTInspector-action for this particular example'>
	
	self addExtension: (self methodResolverClass resolve: GTExampleMethodInspectorActionExtension example: self selector: aSelector)
]

{ #category : #'*GT-Examples-UI-PRAGMA-SELECTORS' }
GTExample >> inspectorActionClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'A method, implemented by (aClassOrClassName >> aSelector), providing a custom GTInspector-actions for this particular example'>
	
	self addExtension: (self methodResolverClass resolve: GTExampleMethodInspectorActionExtension example: self className: aClassOrClassName meta: false selector: aSelector)
]

{ #category : #'*GT-Examples-UI-PRAGMA-SELECTORS' }
GTExample >> inspectorClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'A method, implemented by (aClassOrClassName >> aSelector), providing custom GTInspector-extensions for this particular example'>
	
	self addExtension: (self methodResolverClass resolve: GTExampleMethodInspectorExtension example: self className: aClassOrClassName meta: false selector: aSelector)
]

{ #category : #'*GT-Examples-UI-PRAGMA-SELECTORS' }
GTExample >> spotter: aSelector [
	<gtExamplePragma>
	<description: 'A method, implemented by aSelector, providing a custom GTSpotter-extension for this particular example'>
	
	self addExtension: (self methodResolverClass resolve: GTExampleMethodSpotterExtension example: self selector: aSelector)
]

{ #category : #'*GT-Examples-UI-PRAGMA-SELECTORS' }
GTExample >> spotterClass: aClassOrClassName selector: aSelector [
	<gtExamplePragma>
	<description: 'A method, implemented by (aClassOrClassName >> aSelector), providing a custom GTSpotter-extension for this particular example'>
	
	self addExtension: (self methodResolverClass resolve: GTExampleMethodSpotterExtension example: self className: aClassOrClassName meta: false selector: aSelector)
]

{ #category : #'*GT-Examples-UI' }
GTExample >> spotterPreviewIn: aComposite inContext: aSpotter [
	^ self gtSpotterPreviewIn: aComposite
]
