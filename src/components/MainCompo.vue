<template>
    <div class="back">
        <div class="container">
            <div class="d-flex justify-content-center">
                Select language: 
                <select @change="selectLang" name="lang" id="lang">
                    <option v-for="item, index in langList" :key="index" :value="item.iso_639_1">{{item.english_name}}</option>
                </select>
            </div>
            <h2>FILM</h2>
            <ul>
                <li class="text-center" v-for="item, index in filmList" :key="index">
                    <img :src="`https://image.tmdb.org/t/p/w342/${ item.poster_path }`" :alt="item.title">
                    <div>
                        <div>Titolo: {{item.title}}</div>
                        <div>Titolo originale:{{item.original_title}}</div>
                        <div>Lingua: {{item.original_language}}</div>
                        <div>Voto: {{item.vote_average}}</div>
                    </div>
                </li>
            </ul>
            <h2>SERIE TV</h2>
            <ul>
                <li class="text-center" v-for="item, index in tvList" :key="index">
                    <img :src="`https://image.tmdb.org/t/p/w342/${ item.poster_path }`" :alt="item.name">
                    <div>
                        <div>Titolo: {{item.name}}</div>
                        <div>Titolo originale: {{item.original_name}}</div>
                        <div>Lingua: {{item.original_language}}</div>
                        <div>Voto: {{item.vote_average}}</div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    name: 'MainCompo',
    props: ['text'],
    data() {
        return {
            url: 'https://api.themoviedb.org/3/search/movie?api_key=f2faa276f128d7e15803d0612da76a93&language=it-IT&query=a&page=1&include_adult=false',
            urlTv: 'https://api.themoviedb.org/3/search/tv?page=1&query=a&include_adult=false&api_key=f2faa276f128d7e15803d0612da76a93&language=it-IT',
            langUrl: 'https://api.themoviedb.org/3/configuration/languages?api_key=f2faa276f128d7e15803d0612da76a93',
            filmList: [],
            tvList: [],
            langList: [],
            userText: '',
            userLang: 'it',
            userLangCapital: 'IT',
        }
    },
    methods: {
        getFilm() {
            axios.get(this.url).then((result) =>{
                this.filmList = result.data.results;
            });
            axios.get(this.urlTv).then((result) =>{
                this.tvList = result.data.results;
            });
        },
        searchFilm() {
            this.userText = this.text;
            this.url = `https://api.themoviedb.org/3/search/movie?api_key=f2faa276f128d7e15803d0612da76a93&language=${this.userLang}-${this.userLangCapital}&query=${this.text}&page=1&include_adult=false`;
            this.urlTv = `https://api.themoviedb.org/3/search/tv?page=1&query=${this.userText}&include_adult=false&api_key=f2faa276f128d7e15803d0612da76a93&language=${this.userLang}-${this.userLangCapital}`;
            this.filmList = [];
            this.tvList = [];
            this.getFilm();
        },
        selectLang(value) {
            this.userLang = event.target.value;
            this.userLangCapital = this.userLang.toLocaleUpperCase();
            console.log(value)
            this.searchFilm();
        },
        getLang() {
            axios.get(this.langUrl).then((result) =>{
                this.langList = result.data;
            });
        },
    },
    watch: {
        text() {
            this.searchFilm();
        }
    },
    created() {
        this.getFilm();
        this.getLang();
    },
}
</script>

<style lang="scss" scoped>
@import '../assets/common.scss';
.back {
    background-color: grey;
}
ul {
    list-style-type: none;
    display: flex;
    justify-content: space-evenly;
    flex-wrap: wrap;
    li {
        background-color: black;
        color: white;
        margin: 15px;
    }
}
.d-flex {
    padding: 15px;
}
img {
    width: 342px;
    height: 513px;
}
h2 {
    color: white;
    font-weight: 700;
    font-size: 35px;
    text-align: center;
}

</style>