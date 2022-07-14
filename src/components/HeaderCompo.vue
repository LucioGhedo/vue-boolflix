<template>
    <div class="back">
        <div class="container">
            <div class="d-flex justify-content-between">
                <div class="title">
                    BOOLFLIX
                    <div class="links">
                        <span class="active">Home</span>
                        <span>Serie tv</span>
                        <span>Film</span>
                        <span>Original</span>
                        <span>La mia lista</span>
                    </div>
                </div>
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
.title {
    color: red;
    display: flex;
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
.links {
    font-size: 15px;
    display: flex;
    align-items: center;
    padding-top: 5px;
    span {
        padding: 0 10px;
        color: grey;
        &.active {
            color: white;
        }
    }
}
</style>