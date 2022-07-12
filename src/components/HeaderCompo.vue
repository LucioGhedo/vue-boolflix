<template>
    <div class="back">
        <div class="container">
            <div class="d-flex justify-content-between">
                <div>BOOLFLIX</div>
                <div class="ms_input">
                    <input v-model="userSearch" type="text" name="search" id="search">
                    <button @click="$emit('search', userSearch)" class="btn-primary">Search</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    name: 'HeaderCompo',
    data() {
        return {
            userSearch: '',
        }
    },
    methods: {

    }
}
</script>

<style lang="scss" scoped>
@import '../assets/common.scss';
.back {
    background-color: black;
}
div {
    color: white;
    font-size: 30px;
}
.ms_input {
    display: flex;
    padding: 5px 0;
    input {
        font-size: 15px;
    }
    button {
        font-size: 15px;
    }
}
</style>