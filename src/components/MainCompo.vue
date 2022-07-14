<template>
    <div class="back">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <div class="container_ms">
            <div class="select-lang">
                Select language: 
                <select @change="selectLang" name="lang" id="lang">
                    <option v-for="item, index in langList" :key="index" :value="item.iso_639_1">{{item.english_name}}</option>
                </select>
            </div>
            <h2>FILM</h2>
            <ul>
                <li v-for="item, index in filmList" :key="index">
                    <div class="test">
                        <div class="cover">
                            <img :src="`https://image.tmdb.org/t/p/w342/${ item.poster_path }`" :alt="item.title">
                        </div>
                        <div class="hidden">
                            <div class="title">Titolo: {{item.title}}</div>
                            <div class="title">Titolo originale:{{item.original_title}}</div>
                            <div>
                                <img
                                class="flag"
                                :src="`https://flagcdn.com/16x12/${fixFlag(item.original_language)}.png`"
                                :srcset="`https://flagcdn.com/32x24/${fixFlag(item.original_language)}.png 2x,
                                    https://flagcdn.com/48x36/${fixFlag(item.original_language)}.png 3x`"
                                width="20"
                                :alt="`${item.original_language}`">
                            </div>
                            <div class="stars">
                                <i v-for="n in 5" :key="n" class="fa-regular fa-star" :class="{'gold': n <= voteCalc(item.vote_average) }"></i>
                            </div>
                            <div class="overview">{{item.overview}}</div>
                            <!-- <div>Voto: {{item.vote_average}}</div> -->
                        </div>
                    </div>
                </li>
            </ul>
            <h2>SERIE TV</h2>
            <ul>
                <li class="text-center" v-for="item, index in tvList" :key="index">
                    <div class="cover">
                        <img :src="`https://image.tmdb.org/t/p/w342/${ item.poster_path }`" :alt="item.name">
                    </div>
                    <div class="hidden">
                        <div class="title">Titolo: {{item.name}}</div>
                        <div class="title">Titolo originale: {{item.original_name}}</div>
                        <!-- <div>Lingua: {{item.original_language}}</div> -->
                        <!-- <div v-if="item.original_language == 'en'">Lingua: {{item.original_language}}</div> -->
                        <div>
                            <img
                            class="flag"
                            :src="`https://flagcdn.com/16x12/${fixFlag(item.original_language)}.png`"
                            :srcset="`https://flagcdn.com/32x24/${fixFlag(item.original_language)}.png 2x,
                                https://flagcdn.com/48x36/${fixFlag(item.original_language)}.png 3x`"
                            width="20"
                            :alt="`${item.original_language}`">
                        </div>
                        <div class="stars">
                            <i v-for="n in 5" :key="n" class="fa-regular fa-star" :class="{'gold': n <= voteCalc(item.vote_average) }"></i>
                        </div>
                        <div class="overview">{{item.overview}}</div>
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
        voteCalc(mark) {
            const count = mark / 2;
            return Math.round(count);
        },
        fixFlag(flag) {
        if(flag == 'en'){
            return "gb";
        } else if(flag == 'ja'){
            return "jp";
        } else if(flag == 'hi'){
            return "in";
        } else if(flag == 'cs'){
            return "cz";
        } else if(flag == 'ko'){
            return "kr";
        } else if(flag == 'sv'){
            return "ch";
        } return flag
    }
         
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
    height: 100%;
}
ul {
    list-style-type: none;
    display: flex;
    overflow-x: auto;
    // justify-content: space-evenly;
    // flex-wrap: wrap;
    li {
        background-color: black;
        width: 200px;
        color: white;
        margin: 15px;
        max-height: 33vh;
    }
}
img {
    width: 200px;
    height: 33vh;
}
h2 {
    color: white;
    font-weight: 700;
    font-size: 35px;
    text-align: center;
}
.flag {
    height: 20px;
    width: 25px;
    margin: 15px;
}
.gold {
    color: yellow;
}
.stars {
    font-size: 10px;
    margin: 15px;
}
.cover {
    display: block;
    width: 200px;
}
.hidden {
    display: none;
}
li:hover {
    .cover {
        display: none;
    }
    .hidden {
        display: block;
        width: 200px;
    }
}
ul:last-of-type {
    margin-bottom: 30px;
}
.title {
    font-size: 12px;
    margin: 15px;
}
.lang {
    font-size: 10px;
    margin: 15px;
}
.overview {
    margin: 15px; 
    overflow-y: auto;
    max-height: 70px;
}
.select-lang {
    display: flex;
    justify-content: center;
}
.container_ms {
    width: 90%;
    margin: 0 auto;
}

</style>