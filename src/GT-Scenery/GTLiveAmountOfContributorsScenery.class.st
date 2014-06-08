Class {
	#name : #GTLiveAmountOfContributorsScenery,
	#superclass : #GTScenery,
	#category : #'GT-Scenery'
}

{ #category : #'as yet unclassified' }
GTLiveAmountOfContributorsScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 0.2; 
		parent: #GTScenery;
		label: 'Live - Contributors';
		action:[self new setUp]
]

{ #category : #setUp }
GTLiveAmountOfContributorsScenery >> setUp [
	self cleanWindows.
	(GTPlayground openContents: '''Jean­Baptiste Arnaud, Simon Allier, Philippe Back, Clément Bera, Alexandre Bergel, Torsten Bergmann, Usman Bhatti, Vincent Blondeau, Noury Bouraqadi, Johan Brichau, Camillo Bruni, Sven Van Caekenberghe, Damien Cassou, Nicolas Cellier, Guido Chari, Dimitris Chloupis, Bernardo Contreras, Ben Coman, Gabriel Omar Cotelli, Jordi Delgado, Tommaso Del Sasso, Gisela Decuzzi, Christophe Demarey, Sean DeNigris, Marcus Denker, Martin Dias, Erwan Douaille, Stephane Ducasse, Stephan Eggermont, Pablo Estefo, Luc Fabresse, Johan Fabry, Hilaire Fernandes, Nahuel Garbezza, Leo Gassman, Lucas Giudice, Tudor Girba, Thierry Goubier, Norbert Hartl, Dale Henrichs, Pablo Herrero, Nicolai Hess, Andre Hora, Alejandro Infante, Ricardo Jacas, Henrik Sperre Johansen, Denis Kudryashov, Pavel Krivanek, Juraj Kubelka, Laurent Laffont, Jannik Laval, Max Leske, David Lewis, Diego Lont, Esteban Lorenzano, Stefan Marr, Mariano Martinez Peck, Roberto Minelli, Hernan Morales Durand, Eliot Miranda, Fernando Olivero, Nicolas Papagna Maldonado, Nick Papoylias, Nicolas Passerini, Vanessa Peña, Nicolas Petton, Alain Plantec, Guillermo Polito, Damien Pollet, Sergi Reyner, Jochen Rick, Benjamin Van Ryseghem, Ronie Salgado, Camille Teruel, Juan Pablo Sandoval Alcocer, Samir Saleh, Frank Shearar, Igor Stasenko, Aliaksei Syrel, Sebastian Tleye, Yuriy Tymchuk, Andres Valloud, Martin Walk, Hernan Wilkinson''') maximize
]
