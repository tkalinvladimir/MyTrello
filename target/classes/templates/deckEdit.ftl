<#import "parts/common.ftl" as c>

<@c.page>
<h5>Edit deck: ${deck.name}</h5>


<form action="/deck" method="post"  class="form-inline">
    <input type="text" class = "form-control" name="deckname" value="${deck.name}">
    <input type="hidden" value="${deck.id}" name="deckId">
    <input type="hidden" value="${_csrf.token}" name="_csrf">


    <button type="submit" class="btn-primary ml-2 mt-2">Save</button>
</form>

<hr>


<a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    Add new status
</a>
<div class="collapse mt-2" id="collapseExample">
    <div class="form-group">
        <form action="/deckStatusAdd"  method="post">
            <input type="text" class = "form-control" name="deckstatus" placeholder="Введите статус" />
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <input type="hidden" value="${deck.id}" name="deckId">
            <button type="submit" class="btn-primary ml-2 mt-2">Добавить</button>
        </form>
    </div>
</div>
<hr>


<h5><b>Список статусов</b></h5>
    <#list deck_statuses as deck_status>
    <div class="mt-1 ml-5">

        <form action="/deckStatusDel" method="post">
            <input type="hidden" value="${deck_status.id}" name="deckstatusid">
            <input type="hidden" value="${deck.id}" name="deckId">
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <b>${deck_status.status}</b>
            <button type="submit"  class="btn-primary ml-2 mt-2">X</button>
        </form>

    </div>
    <#else>
    empty
    </#list>

</br>




</@c.page>