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
	<gtInspectorPresentationOrder: 20>
	^ composite smalltalkCode 
		title: 'Source';
		smalltalkClass: [ self methodClass ];
		display: [ self sourceCode ];
		act: [ :text | self methodClass compile: text text notifying: nil ]
			icon: GLMUIThemeExtraIcons glamorousAccept
			on: $s
			entitled: 'Accept';
		act: [ self browse ] 
			icon: GLMUIThemeExtraIcons glamorousBrowse 
			entitled: 'Browse'
]
