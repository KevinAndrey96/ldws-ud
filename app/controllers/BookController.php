<?php
 
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Paginator\Adapter\Model as Paginator;


class BookController extends ControllerBase
{
    
     public function initialize()
    {
        $this->tag->setTitle('About us');
        parent::initialize();
    }

    /**
     * Index action
     */
    public function indexAction()
    {
        $this->persistent->parameters = null;

        //MOSTRAR REGISTROS DE LIBROS
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'Book', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "id";

        $book = Book::find($parameters);
        if (count($book) == 0) {
            $this->flash->notice("The search did not find any book");

            $this->dispatcher->forward([
                "controller" => "book",
                "action" => "index"
            ]);

            return;
        }

        $paginator = new Paginator([
            'data' => $book,
            'limit'=> 10,
            'page' => $numberPage
        ]);

        $this->view->page = $paginator->getPaginate();

        ////////////////////////////////

    }

    /**
     * Searches for book
     */
    public function searchAction()
    {
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'Book', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters = $this->persistent->parameters;
        if (!is_array($parameters)) {
            $parameters = [];
        }
        $parameters["order"] = "id";

        $book = Book::find($parameters);
        if (count($book) == 0) {
            $this->flash->notice("The search did not find any book");

            $this->dispatcher->forward([
                "controller" => "book",
                "action" => "index"
            ]);

            return;
        }

        $paginator = new Paginator([
            'data' => $book,
            'limit'=> 10,
            'page' => $numberPage
        ]);

        $this->view->page = $paginator->getPaginate();
    }

    /**
     * Displays the creation form
     */
    public function newAction()
    {

    }

    /**
     * Edits a book
     *
     * @param string $id
     */
    public function editAction($id)
    {
        if (!$this->request->isPost()) {

            $book = Book::findFirstByid($id);
            if (!$book) {
                $this->flash->error("book was not found");

                $this->dispatcher->forward([
                    'controller' => "book",
                    'action' => 'index'
                ]);

                return;
            }

            $this->view->id = $book->getId();

            $this->tag->setDefault("id", $book->getId());
            $this->tag->setDefault("titulo", $book->getTitulo());
            $this->tag->setDefault("autor", $book->getAutor());
            
        }
    }

    /**
     * Creates a new book
     */
    public function createAction()
    {
        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "book",
                'action' => 'index'
            ]);

            return;
        }

        $book = new Book();
        $book->setid($this->request->getPost("id"));
        $book->settitulo($this->request->getPost("titulo"));
        $book->setautor($this->request->getPost("autor"));
        

        if (!$book->save()) {
            foreach ($book->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "book",
                'action' => 'index'
            ]);

            return;
        }

        $this->flash->success("book was created successfully");

        $this->dispatcher->forward([
            'controller' => "book",
            'action' => 'index'
        ]);
    }

    /**
     * Saves a book edited
     *
     */
    public function saveAction()
    {

        if (!$this->request->isPost()) {
            $this->dispatcher->forward([
                'controller' => "book",
                'action' => 'index'
            ]);

            return;
        }

        $id = $this->request->getPost("id");
        $book = Book::findFirstByid($id);

        if (!$book) {
            $this->flash->error("book does not exist " . $id);

            $this->dispatcher->forward([
                'controller' => "book",
                'action' => 'index'
            ]);

            return;
        }

        $book->setid($this->request->getPost("id"));
        $book->settitulo($this->request->getPost("titulo"));
        $book->setautor($this->request->getPost("autor"));
        

        if (!$book->save()) {

            foreach ($book->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "book",
                'action' => 'edit',
                'params' => [$book->getId()]
            ]);

            return;
        }

        $this->flash->success("book was updated successfully");

        $this->dispatcher->forward([
            'controller' => "book",
            'action' => 'index'
        ]);
    }

    /**
     * Deletes a book
     *
     * @param string $id
     */
    public function deleteAction($id)
    {
        $book = Book::findFirstByid($id);
        if (!$book) {
            $this->flash->error("book was not found");

            $this->dispatcher->forward([
                'controller' => "book",
                'action' => 'index'
            ]);

            return;
        }

        if (!$book->delete()) {

            foreach ($book->getMessages() as $message) {
                $this->flash->error($message);
            }

            $this->dispatcher->forward([
                'controller' => "book",
                'action' => 'search'
            ]);

            return;
        }

        $this->flash->success("book was deleted successfully");

        $this->dispatcher->forward([
            'controller' => "book",
            'action' => "index"
        ]);
    }

}
