Extension { #name : #RGMethodDefinition }

{ #category : #'*gt-inspector' }
RGMethodDefinition >> gtInspectorImplementorsIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite list 
		title: 'Implementors';
		display: [ self compiledMethod implementors ]
]

{ #category : #'*gt-inspector' }
RGMethodDefinition >> gtInspectorSendersIn: composite [
	<gtInspectorPresentationOrder: 30>
	composite list 
		title: 'Senders';
		display: [ self compiledMethod senders ]
]

{ #category : #'*gt-inspector' }
RGMethodDefinition >> gtInspectorSourceIn: composite [
	<gtInspectorPresentationOrder: 30>
	self compiledMethod gtInspectorSourceIn: composite
]
