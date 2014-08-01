Extension { #name : #FileReference }

{ #category : #'*GT-InspectorExtensions-Pillar' }
FileReference >> gtInspectorPillarConfigurationIn: composite [
	<gtInspectorPresentationOrder: 40>
	(self basename = 'pillar.conf')
		ifFalse: [ ^ self ].
	((PRSTONConfigurationInterpreter baseDirectory: self parent)
		buildFromFile: self)
			gtInspectorInputFilesIn: composite
]

{ #category : #'*GT-InspectorExtensions-Pillar' }
FileReference >> gtInspectorPillarIn: composite [
	<gtInspectorPresentationOrder: 40>
	(self extension = 'pillar')
		ifFalse: [ ^ self ].
	
	composite custom: (GLMRubricHighlightedTextPresentation new
		editingMode: [GLMHighlighterTextRubEditingMode forStyler: #GTPillarHighlighterTextDecorator];
		display: [ self readStreamDo: #contents ])
]
