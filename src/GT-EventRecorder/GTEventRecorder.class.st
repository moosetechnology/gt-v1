Class {
	#name : #GTEventRecorder,
	#superclass : #Object,
	#instVars : [
		'collectors',
		'delivery',
		'packing',
		'privacy',
		'announcer'
	],
	#category : #'GT-EventRecorder-Core'
}

{ #category : #delivery }
GTEventRecorder >> activateDelivery [
	^ delivery activate
]

{ #category : #adding }
GTEventRecorder >> addCollector: aGTEventCollector [
	self activateDelivery.
	^ collectors add: aGTEventCollector
]

{ #category : #accessing }
GTEventRecorder >> announcer [
	^ announcer
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
	announcer := Announcer new.
	collectors := GTEventCollectors new.
	delivery := GTEventDelivery new.
	delivery recorder: self.
	packing := GTEventPacking ston.
	privacy := [ Privacy sendDiagnosticsAndUsageData ]
]

{ #category : #testing }
GTEventRecorder >> isDeliveryActive [
	^ delivery isActive
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
