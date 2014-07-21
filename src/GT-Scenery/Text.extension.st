Extension { #name : #Text }

{ #category : #'*GT-Scenery' }
Text class >> loremImpsum [
	
	^ 'Lorem ipsum dolor sit amet,' asText allBold, 

('consectetur adipiscing elit.' asText makeAllColor: Color blue), 

'Integer nec odio.' asText, 

'Praesent libero. Sed cursus ante dapibus diam.' asText, 

(('Sed nisi. Nulla quis sem at nibh elementum imperdiet.'asText addAttribute: TextEmphasis italic from: 1 to: 53 ) makeAllColor: Color red),

'Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa.'asText, 

('Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.' asText allBold makeAllColor: Color green ) 
]
