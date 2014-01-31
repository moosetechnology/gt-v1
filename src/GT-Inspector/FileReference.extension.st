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
			self isRoot 
				ifTrue: [ self children ]
				ifFalse: [ 
					(OrderedCollection 
						with: (self path withParents reverse second asFileReference)) 			
						addAll: self children;
						yourself
					 ] ];
		format: [:each | (self isChildOf: each) 
								ifTrue: [ '..' ] 
								ifFalse: [ each basename ]];
		icon: [ :each | 
			each isDirectory 
				ifTrue: [ GLMUIThemeExtraIcons glamorousOpen ] 
				ifFalse: [ GLMUIThemeExtraIcons glamorousBrowse ] ];
		when: [ self isDirectory and: [
					self children notEmpty] ]
]
