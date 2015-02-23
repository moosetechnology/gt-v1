Extension { #name : #XMLElement }

{ #category : #'*GT-InspectorExtensions-XML' }
XMLElement >> formForImageEntity: imageEntity [
  | imageType parserClassName parserClass parser |
  imageType := imageEntity contentType sub.
  parserClassName := imageType asUppercase, #ReadWriter.
  parserClass := Smalltalk globals at: parserClassName asSymbol.
  parser := parserClass on: imageEntity readStream.
    ^ parser nextImage
]

{ #category : #'*GT-InspectorExtensions-XML' }
XMLElement >> gtDisplayOn: stream [
	stream 
		nextPut: $<;
		nextPutAll: self name.
	self attributeNodes
		do: [:each | 
			stream space.
			each gtDisplayOn: stream ].
	stream nextPut: $>
]

{ #category : #'*GT-InspectorExtensions-XML' }
XMLElement >> gtInspectorImageIn: composite inContext: aGTInspector [
	<gtInspectorPresentationOrder: 40>
	|client url|
	
	(aGTInspector panes size > 1) 
		ifFalse: [ ^ self ].	
	
	client := (aGTInspector panes reversed collect: [ :each | (each port: #entity) value ])
		detect: [ :each | 
			(each isKindOf: ZnClient)
				and: [each request notNil]]
		ifNone: [ ^ self ].
	url := client request absoluteUrl.
	
	^ composite morph 
		title: 'Image';
		display: [ 
			self formForImageEntity:
				(ZnClient new 
      				beOneShot;
      				get: url/ (self attributeNodes attributeValueAt: 'src');
      				entity)];
		when: [ self name = 'img' and: [(self attributeNodes attributeValueAt: 'src') notNil]]
]
