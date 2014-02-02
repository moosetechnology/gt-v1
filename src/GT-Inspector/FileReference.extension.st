Extension { #name : #FileReference }

{ #category : #'*gt-inspector' }
FileReference >> gtInspectorContentsIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite text
			title: 'Contents';
			display: [ :each | each readStreamDo: [ :stream | stream contents ] ];
			when: [ :each | each isFile ]
]

{ #category : #'*gt-inspector' }
FileReference >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list 
		title: 'Items';
		display: [ 
			| children |
			children := self directories, self files.
			self isRoot 
				ifTrue: [ children ]
				ifFalse: [ 
					children asOrderedCollection 
						addFirst: self parent;
						yourself ] ];
		format: [:each | (self isChildOf: each) 
								ifTrue: [ '..' ] 
								ifFalse: [ each basename ]];
		icon: [ :each | 
			each isDirectory 
				ifTrue: [ GLMUIThemeExtraIcons glamorousOpen ] 
				ifFalse: [ GLMUIThemeExtraIcons glamorousBrowse ] ];
		when: #hasChildren
]
