:- module(booking_server,
	  [ server/0,
	    server/1,		
	    create_booking/0
	  ]).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/websocket)).
:- use_module(library(http/html_write)).
:- use_module(library(http/js_write)).
:- use_module(library(http/hub)).
:- use_module(library(debug)).

server :-
	server(3050).

server(Port) :-
	(   current_prolog_flag(gui, true)
	->  prolog_ide(thread_monitor)
	;   true
	),
	create_booking,
	http_server(http_dispatch, [port(Port)]).

:- http_handler(root(.),    booking_page,      []).
:- http_handler(root(booking),
		http_upgrade_to_websocket(
		    accept_booking,
		    [ guarded(false),
		      subprotocols([booking])
		    ]),
		[ id(booking_websocket)
		]).

booking_page(_Request) :-
	reply_html_page(
	    title('SWI-Prolog chat demo'),
	    \booking_page).

booking_page -->
	style,
	html([ h1([id(header)], ['Prolog Hotel Booking'] ),
           div([ id(bookingMain) ], [
            div([ id(row1) ], [
                div([ id(booking1) ], [
                    div([ id(image)] , []),
                    div([ id(info) ], []),
                    button([id(book)], ['Book Now'])
                ]),
                div([ id(booking1) ], [
                    div([ id(image)] , []),
                    div([ id(info) ], []),
                    button([id(book)], ['Book Now'])
                ]),
                div([ id(booking1) ], [
                    div([ id(image)] , []),
                    div([ id(info) ], []),
                    button([id(book)], ['Book Now'])
                ]),
                div([ id(booking1) ], [
                    div([ id(image)] , []),
                    div([ id(info) ], []),
                    button([id(book)], ['Book Now'])
                ])
            ]),
            div([ id(row2) ], [
                div([ id(booking1) ], [
                    div([ id(image)] , []),
                    div([ id(info) ], []),
                    button([id(book)], ['Book Now'])
                ]),
                div([ id(booking1) ], [
                    div([ id(image)] , []),
                    div([ id(info) ], []),
                    button([id(book)], ['Book Now'])
                ]),
                div([ id(booking1) ], [
                    div([ id(image)] , []),
                    div([ id(info) ], []),
                    button([id(book)], ['Book Now'])
                ]),
                div([ id(booking1) ], [
                    div([ id(image)] , []),
                    div([ id(info) ], []),
                    button([id(book)], ['Book Now'])
                ])
            ])
           ])
	     ]).

style -->
	html(style(['body,html { 
                    height:100%; \c
                    overflow: hidden; \c
                    font-family: sans-serif; \c
                    background: url(https://freefrontend.com/assets/img/css-hero-effects/Diagonal-Hero-Div-With-CSS-Star-Animation-Background.gif) no-repeat center center;
                    background-size: cover;
                    margin: 0px;
                }\n',
                '#header{ 
                   padding-left: 30px;
                   color: white;
                }\n',
		        '#bookingMain { 
                    height: 88%;
                    margin-top: -20px;
                    display: flex;
                    flex-direction: column;
                    justify-content: space-evenly;
                    margin-left: 50px;
                    margin-right: 50px;
                }\n',
                '#row1 { 
                    display: flex; \c
                    justify-content: space-evenly;
                }\n',
                '#row2 { 
                    display: flex; \c 
                    justify-content: space-evenly;
                }\n',
                '#booking1 { 
			        border: solid 1px lightgray;
                    border-width: medium;
                    padding: 5px;
                    height: 320px;
                    width: 300px;
                    border-radius: 10px;
                    background-color: whitesmoke;
                }\n',
                '#image { 
                    height: 175px;
                    width: 100%;
                    border-radius: 10px;
                    background-color: grey;
                }\n',
                '#info { 
                    height: 110px;
                    width: 100%;
                }\n',
                '#book { 
                    height: 30px;
                    border-color: #55e674;
                    width: 100%;
                    background-color: #55e674;
                    color: white;
                    border-radius: 10px;
                    outline: none;
                }\n'
		   ])).

accept_booking(WebSocket) :-
	hub_add(booking, WebSocket, _Id).

create_booking :-
	hub_create(booking, Page, _{}),
	thread_create(create_booking(Page), _, [alias(booking)]).

    