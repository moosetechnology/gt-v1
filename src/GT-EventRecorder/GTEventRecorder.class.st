"
I represent an event recorder, an object that collects data and regularly sends them to a server. The data could represent user activity, tool usage, or any other statistic usefule for further analysis. 

I cover data collectors, packing, and delivery objects the way they cooperate together and the collected data are regularly send to server(s). It is not mandatory, but it is supposed that I represent a Singleton pattern.

I collaborate with GTEventCollector objects, that are responsible for collecting data. I keep any number of those objects and whenever GTEventDelivery asks me for collected data, GTEventPacking object packs data from each GTEventCollector and hand them as collection of GTEventBundle objects to the GTEventDelivery. GTEventDelivery sends the bundles to server(s).

Public API and Key Messages

- addCollector: it adds GTEventCollector object and activates delivery process if inactive   
- removeCollector: it removes  GTEventCollector object and deactivates delivery process if there are no other collectors.
- activateDelivery: activates delivery process
- deactivateDelivery: deactivates delivery process

Internal Representation and Key Implementation Points.

    Instance Variables
	announcer:		<Annoucner>
	collectors:		<GTEventCollectors>
	delivery:		<GTEventDelivery>
	packing:		<GTEventPacking>
	privacy:		<true|false|ClosureBlock>

"
Class {
	#name : #GTEventRecorder,
	#superclass : #Object,
	#instVars : [
		'collectors',
		'delivery',
		'packing',
		'privacy'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GT-EventRecorder-Core'
}

{ #category : #cleanup }
GTEventRecorder class >> cleanUp [
	self reset.
]

{ #category : #testing }
GTEventRecorder class >> isGlobalRecorder: aGTEventRecorder [
	^ uniqueInstance 
			ifNil: false
			ifNotNil: [ :anInstance | anInstance == aGTEventRecorder  ]
]

{ #category : #accessing }
GTEventRecorder class >> reset [
	"Stop and remove the process for sending usage data. Delete all recorder that from the queue."
	uniqueInstance ifNil: [ ^ self ].
	uniqueInstance deactivateDelivery ifNotNil: [ :aProcess | 
			[ aProcess terminate ] on: Error do: [ "ignore error" ] ].
	uniqueInstance := nil.
]

{ #category : #accessing }
GTEventRecorder class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ].
]

{ #category : #delivery }
GTEventRecorder >> activateDelivery [
	^ delivery activate
]

{ #category : #adding }
GTEventRecorder >> addCollector: aGTEventCollector [
	self activateDelivery.
	^ collectors add: aGTEventCollector
]

{ #category : #testing }
GTEventRecorder >> canSendDiagnosticsAndUsageData [
	^ privacy value
]

{ #category : #delivery }
GTEventRecorder >> deactivateDelivery [
	^ delivery deactivate
]

{ #category : #delivery }
GTEventRecorder >> deliverNow [
	delivery now
]

{ #category : #accessing }
GTEventRecorder >> delivery [
	"Testing purpose."
	^ delivery
]

{ #category : #configuration }
GTEventRecorder >> deliveryPreSuspendingAction: aBlockClosure [ 
	self delivery preSuspendingAction: aBlockClosure
]

{ #category : #packing }
GTEventRecorder >> flush [
	collectors do: #flush
]

{ #category : #'gt-inspector-extension' }
GTEventRecorder >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^ collectors ifNotNil: [ 
			(collectors gtInspectorItemsIn: composite) ]
]

{ #category : #initialization }
GTEventRecorder >> initialize [
	super initialize.
	collectors := GTEventCollectors new.
	delivery := GTEventDelivery new.
	delivery recorder: self.
	packing := GTEventPacking default.
	privacy := [ Privacy sendDiagnosticsAndUsageData ]
]

{ #category : #testing }
GTEventRecorder >> isDeliveryActive [
	^ delivery isActive
]

{ #category : #testing }
GTEventRecorder >> isGlobalRecorder [
	^ self class isGlobalRecorder: self
]

{ #category : #convenient }
GTEventRecorder >> numberOfCollectors [
	^ collectors size
]

{ #category : #configuration }
GTEventRecorder >> offerDeliveryPermission [
	delivery offerPermission
]

{ #category : #configuration }
GTEventRecorder >> offerPrivacy [
	"testing purpose"
	privacy := true
]

{ #category : #packing }
GTEventRecorder >> pack [
	self canSendDiagnosticsAndUsageData ifFalse: [ ^ self flush; yourself ].
	collectors do: [ :eachCollector | | bundle |
		bundle := packing pack: eachCollector.
		bundle data ifNotEmpty: [ delivery add: bundle ] ].
	self removeLiberatedCollectors.
]

{ #category : #removing }
GTEventRecorder >> removeCollector: aGTEventCollector [ 
	| removedCollector |
	removedCollector := collectors remove: aGTEventCollector.
	collectors size = 0 ifTrue: [ self deactivateDelivery ].
	^ removedCollector
]

{ #category : #removing }
GTEventRecorder >> removeLiberatedCollectors [
	collectors removeLiberatedCollectors
]

{ #category : #configuration }
GTEventRecorder >> withdrawDeliveryPermission [
	delivery withdrawPermission
]

{ #category : #configuration }
GTEventRecorder >> withdrawPrivacy [
	"testing purpose"
	privacy := false
]
