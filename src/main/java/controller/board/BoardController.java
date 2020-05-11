package controller.board;

import domain.board.BoardVO;
import domain.Criteria;
import domain.PageDTO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import service.Board.BoardService;

@Controller
@RequestMapping("/board/freeboard/*")
@Log4j
@AllArgsConstructor
public class  BoardController {

    private BoardService service;

    @GetMapping("/list")
    public void list(Model model, Criteria cri) {

        model.addAttribute("list",service.read(cri));
        model.addAttribute("pageMaker",new PageDTO(cri,service.total(cri)));
    }
    @GetMapping("/register")
    public void register(){

    }
    @PostMapping("/register")
    public String register(BoardVO vo, RedirectAttributes rttr){
        service.regster(vo);
        rttr.addFlashAttribute("result",vo.getB_no());
//        rttr.addAttribute("result",vo.getB_no()); 이것으로 사용하면 값이 파라미터로 넘어가기 때문에 el에서 param.result로 값은 받아야한다.
        return "redirect:/board/freeboard/list";
}
    @GetMapping({"/get","/modify"})
    public void get(@RequestParam("b_no") Long b_no,@ModelAttribute("cri") Criteria cri,Model model){

       model.addAttribute("board",service.get(b_no));
    }
//    @GetMapping("/modify")
//    public void modify(@RequestParam("b_no") Long b_no,Model model){
//        model.addAttribute("board",service.get(b_no));
//    }
    @PostMapping("/modify")
    public String modify(BoardVO vo,Model model,RedirectAttributes rttr){

        if(service.modify(vo)){
            rttr.addFlashAttribute("board","sucess");
        }
        return "redirect:/board/freeboard/list";
    }
    @PostMapping("/remove")
    public String remove(Long b_no, RedirectAttributes rttr){
        if(service.remove(b_no)){
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/board/freeboard/list";
    }


}
