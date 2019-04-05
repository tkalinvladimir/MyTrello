<#import "parts/common.ftl" as c>

<@c.page>
Deck editor

<form action="/deck" method="post">
    <input type="text" name="deckname" value="${deck.name}">
    <input type="hidden" value="${deck.id}" name="deckId">
    <input type="hidden" value="${_csrf.token}" name="_csrf">


    <button type="submit">Save</button>
</form>

<div>------------------------------</div>
<div>
    <form action="/deckStatusAdd" method="post">
        <input type="text" name="deckstatus" placeholder="Введите статус" />
        <input type="hidden" value="${deck.id}" name="deckId">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />



        <button type="submit">Добавить статус</button>
    </form>
</div>


<div>Список статусов</div>
    <#list deck_statuses as deck_status>
    <div>
        <form action="/deckStatusDel" id="form=${deck_status.id}" method="post">
            <input type="text" value="${deck_status.id}" name="deckstatusid">
            <input type="hidden" value="${deck.id}" name="deckId">
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <span>${deck_status.status}</span>
            <button type="submit" form="form=${deck_status.id}">X</button>
        </form>
    </div>
    <#else>
    empty
    </#list>
</@c.page>