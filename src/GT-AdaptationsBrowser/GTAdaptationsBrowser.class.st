Class {
	#name : #GTAdaptationsBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'GT-AdaptationsBrowser'
}

{ #category : #'as yet unclassified' }
GTAdaptationsBrowser >> adaptationContextIn: aComposite [

	"Here should be a GTInspector opened on the context,"
	"however I couldn't embed the inspector inside an expander"

	aComposite table
		title: 'Full Context';
		showOnly: 50;
		display: [ :anObject | anObject astMetaObject targetObject gtInspectorRetrieveVariableValuePairs ];
		sorted: [:assoc1 :assoc2 | assoc1 key < assoc2 key];
		column: 'Variable' evaluated: [:assoc | 
			[ Text fromString: assoc key asString ]
						on: Error
						do: [ Text string: 'error printing' attribute: TextColor red ] ];
		column: 'Value' evaluated: [:assoc | 
			[ Text fromString: (assoc value printString contractTo: 50) ]
						on: Error
						do: [ Text string: 'error printing' attribute: TextColor red ] ];
		send: #value

]

{ #category : #'as yet unclassified' }
GTAdaptationsBrowser >> adaptationDetailsIn: aComposite [
	| accumulator |
	
	accumulator := GLMAccumulator new.
	accumulator 
		show: [ :anotherComposite | 
			anotherComposite title: [ :metaObject | metaObject class asString ].
			self adaptationIn: anotherComposite ].
	aComposite custom: accumulator.
]

{ #category : #'as yet unclassified' }
GTAdaptationsBrowser >> adaptationIn: aComposite [
	
	| expander |
	expander := GLMExpander new.
	expander 
		display: [ :metaObject | metaObject commands ].
	expander
		show: [ :anotherComposite | 
			anotherComposite title: [ :aCommand | aCommand class asString ].
			self adaptationSourceCodeIn: anotherComposite.
			self adaptationContextIn: anotherComposite ].
	aComposite custom: expander
]

{ #category : #'as yet unclassified' }
GTAdaptationsBrowser >> adaptationSourceCodeIn: aComposite [

	aComposite text
		title: 'Source Code';
		display: [ :aCommand | aCommand astMetaObject targetObject].

]

{ #category : #'as yet unclassified' }
GTAdaptationsBrowser >> adaptedObjectsIn: aComposite [
	
	aComposite list
			title: 'Adapted objects';
			display: [:container | container adaptedObjectsAsHashDictionary ] ;
			format: [:each | each value ,'(',each key asString,')'  ];
			updateOn: BFMetaObjectBindingRemoved
				from: [ :metaObjectContainer | metaObjectContainer announcer ];
			updateOn: BFMetaObjectBindingAdded
				from: [ :metaObjectContainer | metaObjectContainer announcer ]
			
]

{ #category : #'as yet unclassified' }
GTAdaptationsBrowser >> compose [

	self tabulator with: [ :browser |
		browser
			row:[:row| row column: #adaptedObjects span: 2; column: #adaptationDetails span:3];
			row: #metaObjectInspector.
	
		browser transmit to: #adaptedObjects; andShow: [:composite | 
			self adaptedObjectsIn: composite ].

		browser transmit 
			to: #adaptationDetails; 
			passivelyFrom: #outer port: #entity; 
			from: #adaptedObjects port: #selection; 
			transformed: [:container :assoc | container metaObjectForHash: assoc key ];
			andShow: [:composite| self adaptationDetailsIn: composite ].

		browser transmit 
			to: #metaObjectInspector; 
			passivelyFrom: #outer port: #entity; 
			from: #adaptedObjects port: #selection; 
			transformed: [:container :assoc | container metaObjectForHash: assoc key ];
			andShow:  [:composite| self metaObjectInspectorIn: composite ] ]
]

{ #category : #'as yet unclassified' }
GTAdaptationsBrowser >> metaObjectInspectorIn: aComposite [

	aComposite dynamic
		display: [ :metaObject | 
			GTInspector new
				noTitle;
				noActions;
				startOn: metaObject ]
]
