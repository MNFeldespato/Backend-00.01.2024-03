const express = require('express');
const bodyparser = require('body-parser');
const app = express();
const port = 3000;
const offset = 0;
let listPokemons = [];

app.use(bodyparser.json())
app.get('/', (req, res) => {
    res.send('Hola Mundo')
});
app.get('/marte', async (req, res) => {
    const NASA_API_KEY = 'VjYnHHFlKSccSRNkug0cWNrZNOMnMHkaDVvbCwWA';
    const response = await fetch(`https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=1&per_page=10&api_key=${NASA_API_KEY}`)
    const data = await response.json();
    res.json(data);
});

app.get('/usuarioRandom', async (req, res) => {
    const response = await fetch('https://randomuser.me/api')
    const data = await response.json()
    res.json(data);
});

app.get('/imagen/:tema/:tamano', async (req, res) => { //imagen/montaña/1-4 de menor(0) a mayor(4)
    const tema = req.params.tema;
    const tamano = parseInt(req.params.tamano);
    const ACCESS_KEY = '7hB5H4UAz3zoIFvigThMi_KCCyredqGZ3WiNYexP_Nc';

    const response = await fetch(`https://api.unsplash.com/search/photos?query=${tema}&per_page=1&orientation=landscape&content_filter=high&client_id=${ACCESS_KEY}`)
    const data = await response.json();
    let imageUrl;
    switch (tamano) {
        case 1:
            imageUrl = data.results[0].urls.raw;
            break;
        case 2:
            imageUrl = data.results[0].urls.full;
            break;
        case 3:
            imageUrl = data.results[0].urls.regular;
            break;
        case 4:
            imageUrl = data.results[0].urls.small;
            break;
        default:
            // Si el tamaño no es válido, enviar un mensaje de error
            return res.status(400).json({ error: 'Tamaño de imagen no válido. Debe ser un número del 1 al 4.' });
    }
    res.json({ imageUrl });
});

app.get('/githubUsuario/:usuario', async (req, res) => { // githubUsuario/MNFeldespato
    const usuario = req.params.usuario;
    const response = await fetch(`https://api.github.com/users/${usuario}`);
    const data = await response.json();
    res.json(data);
});

app.get('/fraseRandom', async (req, res) => {
    const API_KEY = '6AnHcQnJz5pIoRK1TtAqIKM4WHGHPf1dCuWYB9xV'
    const response = await fetch('https://api.quotable.io/random')
    const data = await response.json()
    const frases = {
        Frase: data.content,
        Autor: data.author
    }
    res.json(frases)
});

app.get('/listaProductos', async (req, res) => {
    const response = await fetch('https://fakestoreapi.com/products');
    const data = await response.json();
    const productos = data.map(producto => ({
        Nombre: producto.title,
        Descripcion: producto.description,
        Categoria: producto.category
    }))
    res.json(productos);
});

app.get('/tipoCambio', async (req, res) => {
    $token = 'apis-token-9184.ctyT88guFenS1JmbzA8obzRqiJ3MX9i8'
    const response = await fetch('https://api.apis.net.pe/v2/sunat/tipo-cambio', {
        headers: {
            Referer: 'https://apis.net.pe/tipo-de-cambio-sunat-api',
            Authorization: 'Bearer apis-token-9184.ctyT88guFenS1JmbzA8obzRqiJ3MX9i8'
        }
    });
    const data = await response.json();
    res.json(data);

});

app.get('/bebidas', async (req, res) => {
    try {
        const response = await fetch('https://www.thecocktaildb.com/api/json/v1/1/search.php?s=pisco');
        const data = await response.json();

        const primeraBebida = data.drinks[0];

        const ingredientes = {
            Nombre: primeraBebida.strDrink,
            Instrucciones: primeraBebida.strInstructions,
            Ingredientes: [
                primeraBebida.strIngredient1,
                primeraBebida.strIngredient2,
                primeraBebida.strIngredient3,
                primeraBebida.strIngredient4,
                primeraBebida.strIngredient5
            ]
        };
        res.json(ingredientes);
    } catch (err) {
        console.error('Error:', err);
        res.status(500).json({ error: 'Hubo un problema con la solicitud' });
    }
});

app.get('/topPeliculas', async (req, res) => {

    const url = 'https://api.themoviedb.org/3/movie/top_rated?language=es-US&page=1';
    const options = {
        method: 'GET',
        headers: {
            accept: 'application/json',
            Authorization: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMWJhOWRhYjMzYWU4YmJjZjEzODk3YTIzZDFkNjUyYSIsIm5iZiI6MTcxOTE3MTk2OC41OTk2ODEsInN1YiI6IjY2NzM3YzM0N2UxMTJjZmY4Y2VjNWNlOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.StEkWEaRlH-x1EQBegFCxQMOC-ZC0eO2Ll699lkRk3w'
        }
    };

    fetch(url, options)
        .then(res => res.json())
        .then(json => {
            const peliculas = json.results.map(pelicula => ({
                Titulo: pelicula.original_title,
                Sinopsis: pelicula.overview,
                Puntaje_promedio: pelicula.vote_average
            }));
            res.json(peliculas);
        })
        .catch(err => console.error('error:' + err));

});


app.get('/pokedex', async (req, res) => {
    listPokemons = [];
    const data = await fetch(`https://pokeapi.co/api/v2/pokemon?offset=${offset}&limit=10`)
    const response = await data.json();

    for (const pokemon of response.results) {
        const pokeDetail = await fetch(pokemon.url)

        const pokeData = await pokeDetail.json();

        listPokemons.push({ height: pokeData.height, weight: pokeData.weight, name: pokeData.name, image_path: pokeData.sprites.other['official-artwork'].front_default })
    }
    // console.log(listPokemons);
    res.status(200).json(listPokemons);
});


app.get('/rickandmorty', async (req, res) => {
    try {
        const response = await fetch(`https://rickandmortyapi.com/api/character`);
        if (!response.ok) {
            throw new Error('No se pudo obtener la lista de personajes');
        }
        const data = await response.json();
        const charactersInfo = data.results.map(character => ({
            nombre: character.name,
            genero: character.gender,
            estado: character.status
        }));
        res.json(charactersInfo);
    } catch (error) {
        console.error('Error al obtener datos:', error);
        res.status(500).send(`Error: ${error.message}`);
    }
});

app.get('/rickandmortyAll', async (req, res) => {
    try {
        const response = await fetch(`https://rickandmortyapi.com/api/character`);
        if (!response.ok) {
            throw new Error('No se pudo obtener la lista de personajes');
        }
        const data = await response.json();
        res.json(data)
    } catch (error) {
        console.error('Error al obtener datos:', error);
        res.status(500).send(`Error: ${error.message}`);
    }
});

app.get('/clima', async (req, res) => {  // clima?ciudad=Arequipa
    const { ciudad } = req.query;
    const url = `https://weather-api138.p.rapidapi.com/weather?city_name=${ciudad}`;
    const options = {
        method: 'GET',
        headers: {
            'x-rapidapi-key': '47d107c9cbmshd82b6d916446bd0p136146jsndc7cc342c614',
            'x-rapidapi-host': 'weather-api138.p.rapidapi.com'
        }
    };

    try {
        const response = await fetch(url, options);
        const result = await response.json();
        res.json(result);
    } catch (error) {
        console.error(error);
    }
});

app.get('/pelicula/:id', (req, res) => { //pelicula/129 = viaje de chihiro
    const apiKey = 'f1ba9dab33ae8bbcf13897a23d1d652a'; // clave API
    const movieId = req.params.id; // Obtener el ID de la película
    const url = `https://api.themoviedb.org/3/movie/${movieId}?language=es-US&api_key=${apiKey}`;

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Error en la solicitud de API');
            }
            return response.json();
        })
        .then(movie => {
            const dataMovie = {
                Titulo: movie.title,
                Fecha_de_estreno: movie.release_date,
                Sinopsis: movie.overview,
                Puntuación: movie.vote_average
            }
            res.json(dataMovie);
        })
        .catch(err => {
            console.error('Error:', err);
            res.status(500).json({ error: 'Hubo un error al procesar tu solicitud' });
        });

});

app.get('/pokemon/:id', async (req, res) => {
    const pokeId = req.params.id;
    const response = await fetch(`https://pokeapi.co/api/v2/pokemon/${pokeId}`);
    const data = await response.json();
    const pokeInfo = {
        Nombre: data.name,
        Poderes: data.abilities.map(ability => ability.ability.name)
    };
    res.json(pokeInfo);
});


app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})

