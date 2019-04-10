<#import "parts/common.ftl" as c>

<@c.page>

<script type="text/javascript">
    function cardEditText(id, deckid, csrf, text) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/cardChange', false);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        var body = 'id='+id+'&text='+text+'&deckId='+deckid+'&_csrf='+ csrf;
        xhr.send(body);

        // переделать на онредистейтчендж
        document.location.reload(true);
    }

    function cardDel(id, deckid, csrf) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/cardDel', false);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        var body = 'card_id='+id+'&deckId='+deckid+'&_csrf='+ csrf;
        xhr.send(body);

        // переделать на онредистейтчендж
        document.location.reload(true);

    }

    function cardEditStatus(id, deckid, csrf, status) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/cardChangeStatus', false);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        var body = 'id='+id+'&status='+status+'&deckId='+deckid+'&_csrf='+ csrf;
        xhr.send(body);

        // переделать на онредистейтчендж
        document.location.reload(true);
    }
</script>

<h5><b>${deck.name}</b></h5>
<hr>
<br />


<a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    Add new card
</a>
<div class="collapse mt-2 <#if card??>show</#if>" id="collapseExample" >
    <div class="form-group" action="\addCard">
        <form method="post" action="\addCard" method="post" enctype="multipart/form-data">
            <div class="form-group row col-sm-6">
                <input type="text" name="text" class="form-control ${(textError??)?string('is-invalid', '')}" value="<#if card??>${card.text}</#if>" placeholder="Введите текст"/>
                <#if textError??>
                <div class="invalid-feedback">
                    ${textError}
                </div>
                </#if>
                <input type="hidden" value="${deck.id}" name="deckId">
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
            </div>


            <div class="form-group">
                <div class="custom-file">
                    <input type="file" name="file" id="customFile">
                    <label class="custom-file-label" for="customFile">Choose file</label>
                </div>
            </div>



            <div class="form-group row col-sm-1 mt-1">
                <select name="deckstatus_id" class="form-control">
                    <#if available_statuses??>
                        <#list available_statuses as status2>
                            <option value="${status2.id}">${status2.status}</option>
                        </#list>
                    </#if>
                </select>
                <button type="submit" class="btn-primary ml-2 mt-2">Добавить</button>
            </div>

        </form>
    </div>
</div>



<hr>

<div>Список карточек</div>

<div class="row">
    <div class="col-sm-6">
    <#list cards as card>
    <div class="card my-3" >
        <form class="form-inline">
            <div class="ml-2">
                <#if card.fileName??>
                    <img src="/img/${card.fileName}" class="card-img-top">
                </#if>
            </div>
            <input type="hidden" value="${card.id}" name="card_id" >

            <input type="text" class="form-control ml-2 mr-2" value="${card.text}" name="card_text" onchange="cardEditText(${card.id}, ${deck.id}, '${_csrf.token}', this.value)">

            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <input type="hidden" value="${deck.id}" name="deckId">
            <select name="cardstatus_id" class="form-control" onchange="cardEditStatus(${card.id}, ${deck.id}, '${_csrf.token}', this.value)">
                <#if available_statuses??>
                    <#list available_statuses as status2>
                        <#if status2.id == card.status.id>
                            <option value="${status2.id}" selected>${status2.status}</option>
                        <#else>
                            <option value="${status2.id}">${status2.status}</option>
                        </#if>
                    </#list>
                </#if>
            </select>
            <div class="pull-right">
            <button type="button" class="btn-primary ml-2 mt-2 mb-2" onclick="cardDel(${card.id}, ${deck.id}, '${_csrf.token}')">X</button>
            </div>



        </form>
    </div>
    <#else>
    empty
    </#list>
    </div>



<br />




</@c.page>