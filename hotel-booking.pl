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
	    title('SWI-Prolog Booking Demo'),
	    \booking_page).

booking_page -->
	style,
	html([ h1([id(header)], ['Prolog Hotel Booking'] ),
           div([ id(bookingMain) ], [
            div([ id(row1) ], [
                div([ id(booking1) ], [
                    div([ id(image)] , []),
                    div([ id(form)] , [
                        div([ id(info) ], []),
                        button([id(book), onkeypress('handleInput(event)')], ['Book Now'])
                    ])
                ]),
                div([ id(booking1) ], [
                    div([ id(image)] , []),
                    div([ id(form)], [
                        div([ id(info) ], []),
                        button([id(book), onkeypress('handleInput(event)')], ['Book Now'])
                    ])
                ])
            ]),
            div([ id(row2) ], [
                div([ id(booking1) ], [
                    div([ id(image)] , []),
                    div([ id(form)], [
                        div([ id(info) ], []),
                        button([id(book), onkeypress('handleInput(event)')], ['Book Now'])
                    ])
                ]),
                div([ id(booking1) ], [
                    div([ id(image)] , []),
                    div([ id(form)]  , [
                        div([ id(info) ], []),
                        button([id(book), onkeypress('handleInput(event)')], ['Book Now'])
                    ])
                ])
            ])
           ])
	     ]).

style -->
	html(style(['body,html { 
                    height:100%;
                    overflow: hidden;
                    font-family: sans-serif;
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
                    display: flex;
                    justify-content: space-evenly;
                }\n',
                '#row2 { 
                    display: flex; 
                    justify-content: space-evenly;
                }\n',
                '#booking1 { 
			        border: solid 1px lightgray;
                    border-width: medium;
                    padding: 5px;
                    height: 320px;
                    width: 650px;
                    border-radius: 10px;
                    background-color: whitesmoke;
                    display: flex;
                }\n',
                '#image { 
                    height: 100%;
                    width: 500px;
                    border-radius: 10px;
                    background-color: grey;
                }\n',
                '#info { 
                    height: 265px;
                    width: 290px;
                }\n',
                '#book { 
                    height: 30px;
                    border-color: #2b6dd6;
                    width: 300px;
                    background-color: #2b6dd6;
                    color: white;
                    border-radius: 10px;
                    outline: none;
                }\n',
                '#form {
                    width: 300px;
                    padding: 20px; 
                }\n' 
		   ])).

script -->
	{ http_link_to_id(booking_websocket, [], WebSocketURL) },
	js_script({|javascript(WebSocketURL)||
        function handleInput(e) {
            console.log("foo");
        }

        window.addEventListener("DOMContentLoaded", openWebSocket, false);
	|}).

room(r1, 4).
room(r2, 1).
room(r3, 2).
room(r4, 3).

accept_booking(WebSocket) :-
	hub_add(booking, WebSocket, _Id).

create_booking :-
	hub_create(booking, Page, _{}),
	thread_create(create_booking(Page), _, [alias(booking)]).

    