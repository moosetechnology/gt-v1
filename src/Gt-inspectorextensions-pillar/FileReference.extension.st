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
