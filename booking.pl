%% Connection ref https://github.com/JanWielemaker/swi-chat
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
	server(3080).

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
                    div([ id(image1)] , []),
                    div([ id(form)] , [
                        div([ id(info) ], [
                        	div([ id(infodet)], [
                                h3(id = hotelHeader, ['Hotel 1'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                h4(id = heading4, ['Room Max Occupancy']),
                                h4(id = heading4, ['Price'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['1']),
                                b(id = heading6, ['$100'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['2']),
                                b(id = heading6, ['$200'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['3']),
                                b(id = heading6, ['$300'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['4']),
                                b(id = heading6, ['$400'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['Address']),
                                b(id = heading6, ['1935, Lower Mall.'])
                            ])
                        ]),
                        button([id(book1)], ['Book Now'])
                    ])
                ]),
                div([ id(booking1) ], [
                    div([ id(image2)] , []),
                    div([ id(form)], [
                        div([ id(info) ], [
                        	div([ id(infodet)], [
                                h3(id = hotelHeader, ['Hotel 2'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                h4(id = heading4, ['Room Max Occupancy']),
                                h4(id = heading4, ['Price'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['1']),
                                b(id = heading6, ['$100'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['2']),
                                b(id = heading6, ['$200'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['3']),
                                b(id = heading6, ['$300'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['4']),
                                b(id = heading6, ['$400'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['Address']),
                                b(id = heading6, ['2525, West Mall.'])
                            ])
                        ]),
                        button([id(book2)], ['Book Now'])
                    ])
                ])
            ]),
            div([ id(row2) ], [
                div([ id(booking1) ], [
                    div([ id(image3)] , []),
                    div([ id(form)], [
                        div([ id(info) ], [
                        	div([ id(infodet)], [
                                h3(id = hotelHeader, ['Hotel 3'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                h4(id = heading4, ['Room Max Occupancy']),
                                h4(id = heading4, ['Price'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['1']),
                                b(id = heading6, ['$100'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['2']),
                                b(id = heading6, ['$200'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['3']),
                                b(id = heading6, ['$300'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['4']),
                                b(id = heading6, ['$400'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['Address']),
                                b(id = heading6, ['6363, Agronomy Rd.'])
                            ])
                        ]),
                        button([id(book3)], ['Book Now'])
                    ])
                ]),
                div([ id(booking1) ], [
                    div([ id(image4)] , []),
                    div([ id(form)]  , [
                        div([ id(info) ], [
                        	div([ id(infodet)], [
                                h3(id = hotelHeader, ['Hotel 4'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                h4(id = heading4, ['Room Max Occupancy']),
                                h4(id = heading4, ['Price'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['1']),
                                b(id = heading6, ['$100'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['2']),
                                b(id = heading6, ['$200'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['3']),
                                b(id = heading6, ['$300'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['4']),
                                b(id = heading6, ['$400'])
                            ]),
                            br([]),
                            div([ id(infodet)], [
                                b(id = heading6, ['Address']),
                                b(id = heading6, ['5960, Student Union Blvd.'])
                            ])
                        ]),
                        button([id(book4)], ['Book Now'])
                    ])
                ])
            ])
        ]),
        div([ id = 'modal' ], [
            div([ id = 'modal-content'], [
                form([ id(form) ], [
                    label(for = 'name', 'Name'),
                    br([]),
                    input([id = 'nameinput', type = 'text', placeholder = 'Name', name = 'name', required]),
                    br([]),
                    label(for = 'people', 'Number of people'),
                    br([]),
                    input([id = 'peopleinput', type = 'number', placeholder = 'People', name = 'people', required]),
                    br([]),
                    label(for = 'check-in', 'Check-in date'),
                    br([]),
                    input([id = 'checkininput', type = 'number',  placeholder = 'Check-in', name = 'check-in', required]),
                    br([]),
                    label(for = duration, 'How long is your stay?'),
                    br([]),
                    input([id = 'durationinput', type = 'number', placeholder = 'Duration', name = 'duration', required]),
                    br([]),
                    br([]),
                    button([id = 'submit-form', type = 'submit', onclick = 'submitBookingForm(event)'], ['Submit'])
                ])
            ])
        ]),
        div([ id(footer) ], [
            button([id(output), onclick = 'downloadBookings()'], ['Optimize bookings'])
        ])
	]),
    script.

style -->
	html(style(['body,html { 
                    height:100%;
                    overflow-y: scroll;
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
                    height: 100vh;
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
			        border: solid 6px lightgray;
                    padding: 5px;
                    height: 320px;
                    width: 650px;
                    border-radius: 10px;
                    background-color: whitesmoke;
                    display: flex;
                }\n',
                '#hotelHeader {
                	position: relative;
                	top: -20px;
                	height: -15px;
                	margin: 0px;
                	padding: 0px;
                }\n',
                '#heading4 {
                	position: relative;
                	top: -25px;
                	margin: 0px;
                	padding: 0px;
                }\n',
                '#heading6 {
                	position: relative;
                	top: -30px;
                	margin: 0px;
                	padding: 0px;
                }\n',
                '#image1 { 
                    height: 100%;
                    width: 500px;
                    border-radius: 10px;
                    background-color: grey;
                    background: url(https://www.freevector.com/uploads/vector/preview/28404/3d4.jpg);
                    background-size: cover;
                }\n',
                '#image2 { 
                    height: 100%;
                    width: 500px;
                    border-radius: 10px;
                    background-color: grey;
                    background: url(https://image.freepik.com/free-vector/isometric-hotel-building_23-2148163848.jpg) no-repeat center center;
                    background-size: 122%;
                }\n',
                '#image3 { 
                    height: 100%;
                    width: 500px;
                    border-radius: 10px;
                    background-color: grey;
                    background: url(https://www.freevector.com/uploads/vector/preview/28436/3D5.jpg) no-repeat center center;
                    background-size: cover;
                }\n',
                '#image4 { 
                    height: 100%;
                    width: 500px;
                    border-radius: 10px;
                    background-color: grey;
                    background: url(https://img.freepik.com/free-vector/hotel-building-isometric_98292-5172.jpg?size=338&ext=jpg) no-repeat center center;
                    background-size: cover;
                }\n',
                '#info { 
                    width: 290px;
                    display: flex;
                    justify-content: space-between;
                    flex-direction: column;
                    padding: 20px;
                    height: 125px;
                    padding-bottom: 100px;
                }\n',
                '#infodet {
                	height: auto;
                	margin: 0px;
                    display: flex;
                    justify-content: space-between;
                    padding-right: 20px;
                }\n',
                '#book1 { 
                    height: 30px;
                    border-color: #2b6dd6;
                    width: 300px;
                    background-color: #2b6dd6;
                    color: white;
                    border-radius: 10px;
                    outline: none;
                }\n',
                '#book2 { 
                    height: 30px;
                    border-color: #2b6dd6;
                    width: 300px;
                    background-color: #2b6dd6;
                    color: white;
                    border-radius: 10px;
                    outline: none;
                }\n',
                '#book3 { 
                    height: 30px;
                    border-color: #2b6dd6;
                    width: 300px;
                    background-color: #2b6dd6;
                    color: white;
                    border-radius: 10px;
                    outline: none;
                }\n',
                '#book4 { 
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
                }\n',
                '#modal{
                    display: none;
                    position: fixed;
                    left: 0;
                    top: 0;
                    width: 100%;
                    height: 100%;
                    z-index: 1;
                    overflow: hidden;
                    background-color: rgba(0,0,0,0.4);
                }\n',
                '#modal-content{
                    background-color: #fefefe;
                    margin: 10% auto; /* 15% from the top and centered */
                    padding: 20px;
                    border: 1px solid #888;
                    width: 500px;
                    animation-name: animatetop;
                    animation-duration: 0.4s
                }\n',
                '#form-container{
                    max-width: 300px;
                    padding: 10px;
                    background-color: white;
                }\n',
                'input{
                    width: 250px;
                    outline: none;
                    padding: 15px;
                    margin: 5px 0 22px 0;
                    border: none;
                    background: #f1f1f1;
                }\n',
                '#submit-form{
                    background-color: #2b6dd6;
                    color: white;
                    outline: none;
                    padding: 16px 20px;
                    cursor: pointer;
                    width: 94%;
                    margin-bottom:10px;
                    opacity: 0.8;
                    border-radius: 10px;
                }\n',
                '@keyframes animatetop {
                  from {top: -300px; opacity: 0}
                  to {top: 0; opacity: 1}
                }',
                '#footer{
                    background-color: #000000;
                    height: 140px;
                    width: 100%;
                    display: flex;
                    justify-content: center;
                    margin-top: 20px;
                }\n',
                '#output{
                    background-color: #2b6dd6;
                    color: white;
                    border-color: #2b6dd6;
                    outline: none;
                    width: 200px;
                    margin-top: 40px;
                    height: 50px;
                    border-radius: 30px;
                }\n'
		   ])).

script -->
	{ http_link_to_id(booking_websocket, [], WebSocketURL) },
	js_script({|javascript(WebSocketURL)||
        function openWebSocket() {
          connection = new WebSocket("ws://"+window.location.host+WebSocketURL,
        			     ['booking']);
          console.log("connect");
          connection.onerror = function (error) {
            console.log('WebSocket Error ' + error);
          };
        
        }
        var optimize = '';
        window.KnowledgeBase1 = '';
        window.KnowledgeBase2 = '';
        window.KnowledgeBase3 = '';
        window.KnowledgeBase4 = '';
        window.activeHotel;

        var modal = document.getElementById("modal");

        var btnModal1 = document.getElementById("book1");
        var btnModal2 = document.getElementById("book2");
        var btnModal3 = document.getElementById("book3");
        var btnModal4 = document.getElementById("book4");

        btnModal1.onclick = function(event) {
        	window.activeHotel = 1;
            modal.style.display = "block";

        }

        submitBookingForm = function(event) {
            event.preventDefault();
            let numpeople = document.getElementById('peopleinput');
            let checkin = document.getElementById('checkininput');
            let duration = document.getElementById('durationinput');
            let name = document.getElementById('nameinput');
            document.getElementById("modal").style.display = "none";
            if (window.activeHotel == 1){
            	window.KnowledgeBase1 += 'booking('+name.value.toLowerCase()+','+numpeople.value+','+checkin.value+','+duration.value+').\n';
            	name.value = null;
           		numpeople.value = null;
           		checkin.value = null;
            	duration.value = null;
            } else if (window.activeHotel == 2){
            	window.KnowledgeBase2 += 'booking('+name.value.toLowerCase()+','+numpeople.value+','+checkin.value+','+duration.value+').\n';
            	name.value = null;
           		numpeople.value = null;
           		checkin.value = null;
            	duration.value = null;
            } else if (window.activeHotel == 3){
            	window.KnowledgeBase3 += 'booking('+name.value.toLowerCase()+','+numpeople.value+','+checkin.value+','+duration.value+').\n';
            	name.value = null;
	           	numpeople.value = null;
	           	checkin.value = null;
	            duration.value = null;
            } else {
            	window.KnowledgeBase4 += 'booking('+name.value.toLowerCase()+','+numpeople.value+','+checkin.value+','+duration.value+').\n';
            	name.value = null;
	           	numpeople.value = null;
	           	checkin.value = null;
	            duration.value = null;
            }
            
        }

        
        btnModal2.onclick = function(event) {
        	window.activeHotel = 2;
            modal.style.display = "block";
        }
        
        btnModal3.onclick = function(event) {
        	window.activeHotel = 3;
            modal.style.display = "block";
        }
                
        btnModal4.onclick = function(event) {
        	window.activeHotel = 4
            modal.style.display = "block";
        }
        
        window.onclick = function(event) {
            if(event.target == modal) 
                modal.style.display = "none";
        }

        downloadBookings = function() { 

        	optimize+=`room(r4, 4, 400).

room(r1, 1, 100).
room(r2, 2, 200).
room(r3, 3, 300).

fitsroom(P, R, D) :-
    booking(P, N, D, _),
    room(R, C, _),
    N =< C.

roomsok([]).
roomsok([(_, R1, D)|B]) :-
    \\+ member((_,R1, D), B),
    roomsok(B).
    
peopleok([]).
peopleok([(P, _, D)|B]) :-
    \\+ member((P, _, D), B),
    peopleok(B).

consistentdates([]).
consistentdates([(P, R, D)|B]):-
    booking(P, _, D, L),
    E is D + L - 1,
    foreach(between(D, E, D1), not(member((_, R, D1), B))),
    consistentdates(B).


consistentrooms([]).
consistentrooms([(P, R1, _)|B]):-
    foreach(member((P,R2, _), B), R1 = R2),
    consistentrooms(B).


validbooking(B) :-
    sort(2, @=<, B, Bs), 
    consistentdates(Bs),
    peopleok(Bs).

% https://rosettacode.org/wiki/Power_set#Prolog

powerset(X,Y) :- bagof( S, (subseq(S,X), validbooking(S)), Y).
 
subseq( [], []).
subseq( [], [_|_]).
subseq( [X|Xs], [X|Ys] ) :- subseq(Xs, Ys).
subseq( [X|Xs], [_|Ys] ) :- append(_, [X|Zs], Ys), subseq(Xs, Zs).

lenlist([], 0).
lenlist([_|T], N):-
    lenlist(T, X),
    N is X + 1.


sumcost([],0).
sumcost([(_,R1, _)|T], C):-
    room(R1, _, Y),
    sumcost(T, X),
    C is X + Y.
    
maxfirst(M, M1):-
    sumcost(M, L),
    sumcost(M1, L1),
    L >= L1.

maximize([], []).
maximize(L, M) :-
    member(M, L),
    foreach(member(M1, L), maxfirst(M, M1)).

allvalidbook(Bestbooking, Total):-
    findall((Person, Room, D), (fitsroom(Person, Room, D)), Bag),
    powerset(Bag,Y),
 	maximize(Y, Bestbooking),
    sumcost(Bestbooking, Total).`

            let hotel1 = document.createElement('a');
            hotel1.download = 'h1optimizebookings.pl';
            KnowledgeBase1+= optimize;
	        hotel1.href = "data:application/octet-stream,"+encodeURIComponent(KnowledgeBase1);
	        hotel1.click();

	        let hotel2 = document.createElement('a');
	        hotel2.download = 'h2optimizebookings.pl';
	        KnowledgeBase2+= optimize;
	        hotel2.href = "data:application/octet-stream,"+encodeURIComponent(KnowledgeBase2);
	        hotel2.click();

	        let hotel3 = document.createElement('a');
	        hotel3.download = 'h3optimizebookings.pl';
	        KnowledgeBase3+= optimize;
	        hotel3.href = "data:application/octet-stream,"+encodeURIComponent(KnowledgeBase3);
	        hotel3.click();

	        let hotel4 = document.createElement('a');
	        hotel4.download = 'h4optimizebookings.pl';
	        KnowledgeBase4+= optimize;
	        hotel4.href = "data:application/octet-stream,"+encodeURIComponent(KnowledgeBase4);
	        hotel4.click();
	        }

        window.addEventListener("DOMContentLoaded", openWebSocket, false);
	|}).

accept_booking(WebSocket) :-
	hub_add(booking, WebSocket, _Id).

create_booking :-
	hub_create(booking, Page, _{}),
	thread_create(create_booking(Page), _, [alias(booking)]).

    